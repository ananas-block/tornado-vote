/* global artifacts, web3, contract */

require('chai')
  .use(require('bn-chai')(web3.utils.BN))
  .use(require('chai-as-promised'))
  .should()

require('dotenv').config({ path: '../.env' })
const ERC20Tornado = artifacts.require('ERC20Tornado')
const Verifier = artifacts.require('Verifier')
const hasherContract = artifacts.require('Hasher')
const ERC20Mock = artifacts.require('ERC20Mock')
const ERC20 = artifacts.require('VoteToken');
let Web3 = require('web3');

const VoteTokenJson = require('./../build/contracts/VoteToken.json')


const INITIAL_SUPPLY = parseInt(process.env.INITIAL_SUPPLY)
const YES_ADDRESS =  Web3.utils.toHex(process.env.YES_ADDRESS)
const NO_ADDRESS = Web3.utils.toHex(process.env.NO_ADDRESS)
var MIXCONTRACT_ADDRESS = 0
var EndRegistrationPhase = parseInt(process.env.EndRegistrationPhase)
var EndCommitPhase = parseInt(process.env.EndCommitPhase)
var EndVotingPhase = parseInt(process.env.EndVotingPhase)


module.exports = async function(deployer, network, accounts) {
  console.log("Total Number of Votes: ", INITIAL_SUPPLY)
  console.log("Yes Address: ", YES_ADDRESS)
  console.log("No Address: ", NO_ADDRESS)
  //console.log("Phase 0: ", EndRegistrationPhase)
  var web3;
  if (network == "development"){
    web3 = new Web3('HTTP://127.0.0.1:8545');

  } else if(network == "ropsten"){
    web3 = new Web3(process.env.INFURA_ROPSTEN);
    var blocknr = process.env.BLOCKHEIGHT;
  } else if(network == "kovan"){
    web3 = new Web3(process.env.INFURA_KOVAN);

  } else if(network == "rinkeby"){
    web3 = new Web3(process.env.INFURA_KOVAN);

  }
  var blocknr =await web3.eth.getBlockNumber();
  console.log("Blocknr = ", blocknr)
  EndRegistrationPhase += Number(blocknr);
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
      vote_token =erc20.address
      //console.log("Balance of Account 0, ", await erc20.balanceOf(accounts[0]))

    })
    //console.log(vote_token)



  await deployer.then(async () => {
    const { MERKLE_TREE_HEIGHT, TOKEN_AMOUNT,FEE } = process.env
    const verifier = await Verifier.deployed()
    const hasherInstance = await hasherContract.deployed()
    await ERC20Tornado.link(hasherContract, hasherInstance.address)
    let token = vote_token
    console.log("Address of Votetoken: ", token);

    const tornado = await deployer.deploy(
      ERC20Tornado,
      verifier.address,
      TOKEN_AMOUNT,
      MERKLE_TREE_HEIGHT,
      accounts[0],
      token,
      web3.utils.toWei(FEE)
    )
    console.log('ERC20Tornado\'s address ', tornado.address)


  })
}
