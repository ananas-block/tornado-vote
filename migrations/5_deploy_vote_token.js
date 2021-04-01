require('dotenv').config()
const ERC20 = artifacts.require('VoteToken');
let Web3 = require('web3');
var web3 = new Web3('HTTP://127.0.0.1:8545');
/*
const INITIAL_SUPPLY = process.env.INITIAL_SUPPLY
const YES_ADDRESS = process.env.YES_ADDRESS
const NO_ADDRESS = process.env.NO_ADDRESS
const MIXCONTRACT_ADDRESS = process.env.MIXCONTRACT_ADDRESS
const EndRegistrationPhase = process.env.EndRegistrationPhase
const EndCommitPhase = process.env.EndCommitPhase
const EndVotingPhase = process.env.EndVotingPhase
*/

const INITIAL_SUPPLY = 5
const YES_ADDRESS = Web3.utils.toHex("0xB4F5663773fB2842d1A74B2da0b5ec95f2ac125A")
const NO_ADDRESS = Web3.utils.toHex("0x4333dD7Cc5349D6DAB1e9621E07319eda0d7c593")
const MIXCONTRACT_ADDRESS ="0xf1d5aed467D7D8972537944C58F89d4EFD92B672"
var EndRegistrationPhase = 10
var EndCommitPhase = 200
var EndVotingPhase = 1000

module.exports = async function (deployer, network, accounts) {
  console.log(INITIAL_SUPPLY)
  console.log(YES_ADDRESS)
  //console.log(web3.isAddress(web3.toHex(YES_ADDRESS)))
  var blocknr =await web3.eth.getBlockNumber();
  EndRegistrationPhase += blocknr;
  console.log("Registrationphase will end at block ", EndRegistrationPhase);
  EndCommitPhase += EndRegistrationPhase;
  console.log("Commitphase will end at block", EndCommitPhase);
  EndVotingPhase +=EndCommitPhase;
  console.log("Votingphase will end at block", EndVotingPhase);

  await deployer.deploy(
    ERC20,
    INITIAL_SUPPLY,
    YES_ADDRESS,
    NO_ADDRESS,
    //MIXCONTRACT_ADDRESS,
    EndRegistrationPhase,
    EndCommitPhase,
    EndVotingPhase
    )/*
    .then(async function (erc20) {

        for (acc =1 ; acc < INITIAL_SUPPLY; acc++){
        await erc20.transfer(accounts[acc],1);
        console.log("tranferred a voting token to ", accounts[acc]);
      }
      await erc20.mixcontract().then(function (res) {console.log(res)});


    })

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
    }*/
    //return erc20.address;

}
