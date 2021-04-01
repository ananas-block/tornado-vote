/* global artifacts */
require('dotenv').config({ path: '../.env' })
const ERC20Tornado = artifacts.require('ERC20Tornado')
const Verifier = artifacts.require('Verifier')
const hasherContract = artifacts.require('Hasher')
const ERC20Mock = artifacts.require('ERC20Mock')
const ERC20 = artifacts.require('VoteToken');
let Web3 = require('web3');
var web3 = new Web3('HTTP://127.0.0.1:8545');


const INITIAL_SUPPLY = parseInt(process.env.INITIAL_SUPPLY)
const YES_ADDRESS =  Web3.utils.toHex(process.env.YES_ADDRESS)
const NO_ADDRESS = Web3.utils.toHex(process.env.NO_ADDRESS)
var MIXCONTRACT_ADDRESS = 0
var EndRegistrationPhase = parseInt(process.env.EndRegistrationPhase)
var EndCommitPhase = parseInt(process.env.EndCommitPhase)
var EndVotingPhase = parseInt(process.env.EndVotingPhase)

async function setMixcontractAddress(tokenAddress, mixAddress, senderAccount) {
  const erc20ContractJson = require('./../build/contracts/VoteToken.json')
  erc20 = new web3.eth.Contract(erc20ContractJson.abi, tokenAddress);

  var x = await erc20.methods.mixcontract().call();
  if(x == '0x0000000000000000000000000000000000000000'){
    //console.log(x)
    mixcontract = await erc20.methods.setMixcontract(mixAddress).send({ from: senderAccount, gas: 2e6 });
    x = await erc20.methods.mixcontract().call();
    console.log("set anonymity provider address to ", x);
  }

}

module.exports = async function(deployer, network, accounts) {
  console.log("Number of Votes: ", INITIAL_SUPPLY)
  console.log("Yes Address: ", YES_ADDRESS)
  console.log("No Address: ", NO_ADDRESS)
  console.log("Phase 0: ", EndRegistrationPhase)

  //console.log(web3.isAddress(web3.toHex(YES_ADDRESS)))
  var blocknr =await web3.eth.getBlockNumber();
  EndRegistrationPhase += blocknr;
  console.log("Registrationphase will end at block ", EndRegistrationPhase);
  EndCommitPhase += EndRegistrationPhase;
  console.log("Commitphase will end at block", EndCommitPhase);
  EndVotingPhase +=EndCommitPhase;
  console.log("Votingphase will end at block", EndVotingPhase);
  let vote_token;
  await deployer.deploy(
    ERC20,
    INITIAL_SUPPLY,
    YES_ADDRESS,
    NO_ADDRESS,
    //MIXCONTRACT_ADDRESS,
    EndRegistrationPhase,
    EndCommitPhase,
    EndVotingPhase
    )
    .then(async function (erc20) {

        for (acc =1 ; acc < INITIAL_SUPPLY; acc++){
        await erc20.transfer(accounts[acc],1);
        console.log("tranferred a voting token to ", accounts[acc]);
      }
      await erc20.mixcontract().then(function (res) {console.log(res)});
      vote_token =erc20.address
    })
    console.log(vote_token)
    blocknr = await web3.eth.getBlockNumber();

    while(EndRegistrationPhase!= blocknr){
      //accounts[0].send(Web3.utils.toHex(0), 0.001)
      web3.eth.sendTransaction({
          from: accounts[0],
          to: '0x0000000000000000000000000000000000000000',
          value: '1'
      })
      blocknr = await web3.eth.getBlockNumber();
      console.log(blocknr)
    }

  await deployer.then(async () => {
    const { MERKLE_TREE_HEIGHT, TOKEN_AMOUNT } = process.env
    const verifier = await Verifier.deployed()
    const hasherInstance = await hasherContract.deployed()
    await ERC20Tornado.link(hasherContract, hasherInstance.address)
    let token = vote_token
    console.log("Address of Votetoken: ", token);
    if(token === '') {
      const tokenInstance = await deployer.deploy(ERC20Mock)
      token = tokenInstance.address
      //console.log("ERC 20 toke address ", token)
    }
    const tornado = await deployer.deploy(
      ERC20Tornado,
      verifier.address,
      TOKEN_AMOUNT,
      MERKLE_TREE_HEIGHT,
      accounts[0],
      token,
    )
    console.log('ERC20Tornado\'s address ', tornado.address)

    senderAccount = (await web3.eth.getAccounts())[0]
    await setMixcontractAddress(vote_token,tornado.address, senderAccount)


  })
}
