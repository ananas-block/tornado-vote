#!/usr/bin/env node
// Temporary demo client
// Works both in browser and node.js

require('dotenv').config()
const fs = require('fs')
const axios = require('axios')
const assert = require('assert')
const snarkjs = require('snarkjs')
const crypto = require('crypto')
const circomlib = require('circomlib')
const bigInt = snarkjs.bigInt
const merkleTree = require('./lib/MerkleTree')
const Web3 = require('web3')
const buildGroth16 = require('websnark/src/groth16')
const websnarkUtils = require('websnark/src/utils')
const { toWei, fromWei, toBN, BN } = require('web3-utils')
const config = require('./config')
const program = require('commander')
const VoteTokenJson =  require('./build/contracts/VoteToken.json')
var https = require('https');


//const voteerc = require('../VoteErc20/script.js')

let web3, tornado, circuit, proving_key, groth16, voteToken, senderAccount, netId
let MERKLE_TREE_HEIGHT, ETH_AMOUNT, TOKEN_AMOUNT, PRIVATE_KEY, PARTICIPANTS_PATH

/** Whether we are in a browser or node.js */
const inBrowser = (typeof window !== 'undefined')
let isLocalRPC = false

/** Generate random number of specified byte length */
const rbigint = nbytes => snarkjs.bigInt.leBuff2int(crypto.randomBytes(nbytes))

/** Compute pedersen hash */
const pedersenHash = data => circomlib.babyJub.unpackPoint(circomlib.pedersenHash.hash(data))[0]

/** BigNumber to hex string of specified length */
function toHex(number, length = 32) {
  const str = number instanceof Buffer ? number.toString('hex') : bigInt(number).toString(16)
  return '0x' + str.padStart(length * 2, '0')
}

/** Display ETH account balance */
async function printETHBalance({ address, name }) {
  console.log(`${name} ETH balance is`, web3.utils.fromWei(await web3.eth.getBalance(address)))
}

/** Display ERC20 account balance */
async function printERC20Balance({ address, name, tokenAddress }) {
  const voteTokenJson = require('./build/contracts/ERC20Mock.json')
  voteToken = tokenAddress ? new web3.eth.Contract(voteTokenJson.abi, tokenAddress) : voteToken

  console.log(`${name} Token Balance is`, await voteToken.methods.balanceOf(address).call())
}


function sleep(milliseconds) {
   return new Promise(resolve => setTimeout(resolve, milliseconds));
}

/**
 * Create deposit object from secret and nullifier
 */
function createDeposit({ nullifier, secret}) {
  const deposit = { nullifier, secret }
  deposit.preimage = Buffer.concat([deposit.nullifier.leInt2Buff(31), deposit.secret.leInt2Buff(31)])
  deposit.commitment = pedersenHash(deposit.preimage)
  deposit.commitmentHex = toHex(deposit.commitment)
  deposit.nullifierHash = pedersenHash(deposit.nullifier.leInt2Buff(31))
  deposit.nullifierHex = toHex(deposit.nullifierHash)
  return deposit
}

/**
 * Make a deposit
 * @param currency Сurrency
 * @param amount Deposit amount
 */
async function deposit(netId, sender) {
  console.log("Sender = ", senderAccount)

  const deposit = createDeposit({ nullifier: rbigint(31), secret: rbigint(31)})
  const note = toHex(deposit.preimage, 62)

  const noteString = `tornado-vote-${voteToken._address}-${netId}-${note}`

  console.log(`Your note: ${noteString}`)
  //console.log("Your randomness is :", randomness);
  //console.log("Your Commitment is :", commit);

    if(sender){
      senderAccount = sender;
      console.log("Changed sender Account to ", senderAccount);
    }
    if(tornado._address == null){
      var netId = process.env.NET_ID;

      let erc20tornadoJson = require('./build/contracts/ERC20Tornado.json')

      let tornadoAddress = erc20tornadoJson.networks[netId].address
      console.log("Tornado address ", tornadoAddress)
      tornado = await new web3.eth.Contract(erc20tornadoJson.abi, tornadoAddress)
      tornado._address = tornadoAddress
    }
    console.log(tornado._address)
    console.log(`Sender Account : `, senderAccount)
    await printERC20Balance({ address: tornado._address, name: 'Tornado' })
    await printERC20Balance({ address: senderAccount, name: 'Sender account'})
    const tokenAmount = 1


    const allowance = await voteToken.methods.allowance(senderAccount, tornado._address).call({ from: senderAccount })
    console.log('Current allowance is', allowance)
    //console.log(tokenAmount)
    //if (toBN(allowance).lt(toBN(tokenAmount))) {
      console.log('Approving tokens for deposit', tokenAmount)
      var x = await voteToken.methods.approve(tornado._address, tokenAmount).send({from: senderAccount, gas: 1e6 })
    //}
    //console.log("approval : ",x)
    console.log('Submitting deposit transaction')
    let fee = process.env.FEE;
    console.log("Fee", fee)
    let value = (toWei((process.env.FEE))*2).toString();
    console.log("Value is: ", fromWei(value));
    var res = await tornado.methods.deposit(toHex(deposit.commitment)).send({value:value, from: senderAccount, gas: 2e6 })
    .on('transactionHash', function (txHash) {
      if (netId === 1 || netId === 42) {
        console.log(`View transaction on etherscan https://${getCurrentNetworkName()}etherscan.io/tx/${txHash}`)
      } else {
        console.log(`The transaction hash is ${txHash}`)
      }
    }).on('error', function (e) {
      console.error('on transactionHash error', e.message)
    })
    //console.log(res);
    await printERC20Balance({ address: tornado._address, name: 'Tornado' })
    await printERC20Balance({ address: senderAccount, name: 'Sender account' })
  //}

  return noteString
}

/**
 * Generate merkle tree for a deposit.
 * Download deposit events from the tornado, reconstructs merkle tree, finds our deposit leaf
 * in it and generates merkle proof
 * @param deposit Deposit object
 */
async function generateMerkleProof(deposit) {
  // Get all deposit events from smart contract and assemble merkle tree from them
  console.log('Getting current state from tornado contract')
  const events = await tornado.getPastEvents('Deposit', { fromBlock: 0, toBlock: 'latest' })
  const leaves = events
    .sort((a, b) => a.returnValues.leafIndex - b.returnValues.leafIndex) // Sort events in chronological order
    .map(e => e.returnValues.commitment)
  const tree = new merkleTree(MERKLE_TREE_HEIGHT, leaves)

  // Find current commitment in the tree
  const depositEvent = events.find(e => e.returnValues.commitment === toHex(deposit.commitment))
  const leafIndex = depositEvent ? depositEvent.returnValues.leafIndex : -1

  // Validate that our data is correct
  const root = await tree.root()
  const isValidRoot = await tornado.methods.isKnownRoot(toHex(root)).call()
  const isSpent = await tornado.methods.isSpent(toHex(deposit.nullifierHash)).call()
  assert(isValidRoot === true, 'Merkle tree is corrupted')
  assert(isSpent === false, 'The note is already spent')
  assert(leafIndex >= 0, 'The deposit is not found in the tree')

  // Compute merkle proof of our commitment
  return tree.path(leafIndex)
}

/**
 * Generate SNARK proof for withdrawal
 * @param deposit Deposit object
 * @param recipient Funds recipient
 * @param relayer Relayer address
 * @param fee Relayer fee
 * @param refund Receive ether for exchanged tokens
 */
async function generateProof({ deposit, recipient, relayerAddress = 0, fee = 0, refund = 0 }) {
  // Compute merkle proof of our commitment
  const { root, path_elements, path_index } = await generateMerkleProof(deposit)
  console.log(recipient)
  // Prepare circuit input
  const input = {
    // Public snark inputs
    root: root,
    nullifierHash: deposit.nullifierHash,
    recipient: bigInt(recipient),
    relayer: bigInt(relayerAddress),
    fee: bigInt(fee),
    refund: bigInt(refund),

    // Private snark inputs
    nullifier: deposit.nullifier,
    secret: deposit.secret,
    pathElements: path_elements,
    pathIndices: path_index,
  }
  console.log("----------------------------------")

  console.log('Generating SNARK proof')
  console.time('Proof time')
  const proofData = await websnarkUtils.genWitnessAndProve(groth16, input, circuit, proving_key)

  const { proof } = websnarkUtils.toSolidityInput(proofData)
  console.timeEnd('Proof time')

  const args = [
    toHex(input.root),
    toHex(input.nullifierHash),
    toHex(input.recipient, 20),
    toHex(input.relayer, 20),
    toHex(input.fee),
    toHex(input.refund)
  ]

  return { proof, args }
}

/**
 * Do an ETH withdrawal
 * @param noteString Note to commit
 * @param recipient Recipient address
 */
async function commit({ deposit, vote, relayerURL, refund = '0' }, sender) {
  if (sender) {
    senderAccount = sender
  }

  if (relayerURL) {
    console.log('Relay url ', relayerURL)

    if (relayerURL.endsWith('.eth')) {
      throw new Error('ENS name resolving is not supported. Please provide DNS name of the relayer. See instuctions in README.md')
    }
    /*
    const relayerStatus = await axios.get(relayerURL + '/status')
    console.log(relayerStatus)
    var { relayerAddress, netId, gasPrices, ethPrices, tornadoServiceFee } = relayerStatus.data
    //20000000000
    assert(netId === await web3.eth.net.getId() || netId === '*', 'This relay is for different network')
    //relayerAddress = '0'

    gasPrices = fromWei('20000000000')
    //tornadoServiceFee = toWei('0.1') * 0.05
    console.log('Relay url ',  relayerAddress, netId, gasPrices, ethPrices, tornadoServiceFee)
      */
    //console.log('Relay address: ', relayerAddress)

    //const fee = calculateFee({ gasPrices, currency, amount, refund, ethPrices, tornadoServiceFee, decimals })
    let relayerAddress
    console.log('Relay url ', relayerAddress)
    /*
    if (fee.gt(fromDecimals({ amount, decimals }))) {
      throw new Error('Too high refund')
    }*/
    let vote_commitment_secret = rbigint(31)
    var vote_choice = new Uint8Array(1);
    //console.log("Your vote Choice is ", vote)
    if(vote == 'yes'){
      vote_choice[0] = 1;
      console.log("Your vote Choice is ", vote)
    }
    else if (vote == 'no'){
      vote_choice[0] = 0;
      console.log("Your vote Choice is ", vote)
    }
    else {
      vote_choice[0] = 2;
      console.log("You are committing to an invalid vote");
    }
    //console.log("Your vote is: ", vote_choice[0]);
    var inst_arr = Buffer.from(vote_choice.buffer);
    //console.log("vote buffer is ", inst_arr);
    //Concatinating the vote and random number
    const buf_t = Buffer.concat([vote_commitment_secret.leInt2Buff(31),inst_arr], 32 );
    //console.log("vote buffer is ", buf_t[31]);
    console.log("Your vote_commitment_secret is : ", web3.utils.bytesToHex(buf_t))

    //let hash2 = Web3.utils.sha3(web3.utils.hexToBytes(buf_t))
    let vote_commitment_hash = Web3.utils.sha3(buf_t)
    var buf = Buffer.from(web3.utils.hexToBytes(vote_commitment_hash))
    //console.log("Hash2 ", hash2)
    //console.log("Sha3 hash ", vote_commitment_hash)
    //console.log("Sha3 hash buffer ", buf);

    let slice = buf.slice(0, 20)
    vote_commitment_hash = web3.utils.bytesToHex(slice)// hash slicefirst20 converttou160 encodeashex

    //console.log("First 20 bytes Sha3 hash buffer ", toHex(vote_commitment_hash,20));
    //console.log(toHex(vote_commitment_hash,20))
    //console.log("----------------------------------")
    recipient = vote_commitment_hash;//vote_commitment_hash;
    //relayerAddress = '0x6bb38eed7Ca866D890550aDC0Ad79B723228Fb20'
    const { proof, args } = await generateProof({ deposit, recipient, relayerAddress })
    console.log(proof);
    console.log(args);
    console.log('Sending commit transaction through relay',  tornado._address)
    try {
      const relay = await axios.post(relayerURL + '/relay', { address: tornado._address,proof: proof,args: args, type: "commit" }, {
          httpsAgent: new https.Agent({rejectUnauthorized: false })
        })
      if (netId === 1 || netId === 42) {
        console.log(`Transaction submitted through the relay. View transaction on etherscan https://${getCurrentNetworkName()}etherscan.io/tx/${relay.data.txHash}`)
      } else {
        console.log(`Transaction submitted through the relay. The transaction hash is ${relay.data.txHash}`)
      }
      /*
      const receipt = await waitForTxReceipt({ txHash: relay.data.txHash })
      console.log('Transaction mined in block', receipt.blockNumber)*/
    } catch (e) {
      if (e.response) {
        console.error(e.response.data.error)
      } else {
        console.error(e.message)
      }
    }
  } else {
    let vote_commitment_secret = rbigint(31)
    var vote_choice = new Uint8Array(1);
    if(vote == 'yes'){
      vote_choice[0] = 1;
    }
    else if (vote == 'no'){
      vote_choice[0] = 0;
    }
    else {
      vote_choice[0] = 2;
      console.log("You are committing to an invalid vote");
    }
    var inst_arr = Buffer.from(vote_choice.buffer);
    //Concatinating the vote and random number
    const buf_t = Buffer.concat([vote_commitment_secret.leInt2Buff(31),inst_arr], 32 );
    console.log("Your vote_commitment_secret is : ", web3.utils.bytesToHex(buf_t))

    let vote_commitment_hash = Web3.utils.sha3(buf_t)
    var buf = Buffer.from(web3.utils.hexToBytes(vote_commitment_hash))

    let slice = buf.slice(0, 20)
    vote_commitment_hash = web3.utils.bytesToHex(slice)

    recipient = vote_commitment_hash;
    const { proof, args } = await generateProof({ deposit, recipient, refund })

    console.log('Submitting commit transaction from ', senderAccount);

    console.log(args);
    let x = await tornado.methods.commit(proof, ...args).send({ from: senderAccount, value: refund.toString(), gas: 1e6 })
      .on('transactionHash', function (txHash) {
        if (netId === 1 || netId === 42) {
          console.log(`View transaction on etherscan https://${getCurrentNetworkName()}etherscan.io/tx/${txHash}`)
        } else {
          console.log(`The transaction hash is ${txHash}`)
        }
      }).on('error', function (e) {
        console.error('on transactionHash error', e.message)
      })

  console.log("Secret ", web3.utils.bytesToHex(buf_t))
  return web3.utils.bytesToHex(buf_t);

  }

}

function fromDecimals({ amount, decimals }) {
  //amount = amount//.toString()
  console.log(amount)
  let ether = amount//.toString()
  const base = new BN('10').pow(new BN(decimals))
  const baseLength = base.toString(10).length - 1 || 1

  const negative = ether.substring(0, 1) === '-'
  if (negative) {
    ether = ether.substring(1)
  }

  if (ether === '.') {
    throw new Error('[ethjs-unit] while converting number ' + amount + ' to wei, invalid value')
  }

  // Split it into a whole and fractional part
  const comps = ether.split('.')
  if (comps.length > 2) {
    throw new Error(
      '[ethjs-unit] while converting number ' + amount + ' to wei,  too many decimal points'
    )
  }

  let whole = comps[0]
  let fraction = comps[1]

  if (!whole) {
    whole = '0'
  }
  if (!fraction) {
    fraction = '0'
  }
  if (fraction.length > baseLength) {
    throw new Error(
      '[ethjs-unit] while converting number ' + amount + ' to wei, too many decimal places'
    )
  }

  while (fraction.length < baseLength) {
    fraction += '0'
  }

  whole = new BN(whole)
  fraction = new BN(fraction)
  let wei = whole.mul(base).add(fraction)

  if (negative) {
    wei = wei.mul(negative)
  }

  return new BN(wei.toString(10), 10)
}

function toDecimals(value, decimals, fixed) {
  const zero = new BN(0)
  const negative1 = new BN(-1)
  decimals = decimals || 18
  fixed = fixed || 7

  value = new BN(value)
  const negative = value.lt(zero)
  const base = new BN('10').pow(new BN(decimals))
  const baseLength = base.toString(10).length - 1 || 1

  if (negative) {
    value = value.mul(negative1)
  }

  let fraction = value.mod(base).toString(10)
  while (fraction.length < baseLength) {
    fraction = `0${fraction}`
  }
  fraction = fraction.match(/^([0-9]*[1-9]|0)(0*)/)[1]

  const whole = value.div(base).toString(10)
  value = `${whole}${fraction === '0' ? '' : `.${fraction}`}`

  if (negative) {
    value = `-${value}`
  }

  if (fixed) {
    value = value.slice(0, fixed)
  }

  return value
}

function getCurrentNetworkName() {
  switch (netId) {
  case 1:
    return ''
  case 42:
    return 'kovan.'
  }

}

function calculateFee({ gasPrices, currency, amount, refund, ethPrices, tornadoServiceFee, decimals }) {
  console.log({ gasPrices, currency, amount, refund, ethPrices, tornadoServiceFee, decimals })
  console.log(tornadoServiceFee.toString().split('.')[1].length)
  const decimalsPoint = Math.floor(tornadoServiceFee) === Number(tornadoServiceFee) ?
    0 :
    tornadoServiceFee.toString().split('.')[1].length
  const roundDecimal = 10 ** decimalsPoint

  const total = toBN(fromDecimals({ amount, decimals }))
  const feePercent = total.mul(toBN(tornadoServiceFee * roundDecimal)).div(toBN(roundDecimal * 100))

  //console.log(gasPrices)
  const expense = toBN(toWei(gasPrices.toString(), 'gwei')).mul(toBN(5e5))

  let desiredFee
  switch (currency) {
  case 'eth': {
    desiredFee = expense.add(feePercent)
    break
  }
  default: {
    desiredFee = expense.add(toBN(refund))
      .mul(toBN(10 ** decimals))
      .div(toBN(ethPrices[currency]))
    desiredFee = desiredFee.add(feePercent)
    break
  }
  }
  return desiredFee
}

/**
 * Waits for transaction to be mined
 * @param txHash Hash of transaction
 * @param attempts
 * @param delay
 */
function waitForTxReceipt({ txHash, attempts = 60, delay = 1000 }) {
  return new Promise((resolve, reject) => {
    const checkForTx = async (txHash, retryAttempt = 0) => {
      const result = await web3.eth.getTransactionReceipt(txHash)
      if (!result || !result.blockNumber) {
        if (retryAttempt <= attempts) {
          setTimeout(() => checkForTx(txHash, retryAttempt + 1), delay)
        } else {
          reject(new Error('tx was not mined'))
        }
      } else {
        resolve(result)
      }
    }
    checkForTx(txHash)
  })
}

/**
 * Parses Tornado.cash note
 * @param noteString the note
 */
function parseNote(noteString) {
  let tokenaddress
  const noteRegex = /tornado-vote-(?<tokenaddress>\w+)-(?<netId>\d+)-0x(?<note>[0-9a-fA-F]{124})/g
  const match = noteRegex.exec(noteString)
  if (!match) {
    throw new Error('The note has invalid format')
  }

  const buf = Buffer.from(match.groups.note, 'hex')
  const nullifier = bigInt.leBuff2int(buf.slice(0, 31))
  const secret = bigInt.leBuff2int(buf.slice(31, 62))
  const deposit = createDeposit({ nullifier, secret })
  const netId = Number(match.groups.netId)

  return {tokenaddress, netId, deposit }
}

async function loadDepositData({ deposit }) {
  try {
    const eventWhenHappened = await tornado.getPastEvents('Deposit', {
      filter: {
        commitment: deposit.commitmentHex
      },
      fromBlock: 0,
      toBlock: 'latest'
    })
    if (eventWhenHappened.length === 0) {
      throw new Error('There is no related deposit, the note is invalid')
    }

    const { timestamp } = eventWhenHappened[0].returnValues
    const txHash = eventWhenHappened[0].transactionHash
    const isSpent = await tornado.methods.isSpent(deposit.nullifierHex).call()
    const receipt = await web3.eth.getTransactionReceipt(txHash)

    return { timestamp, txHash, isSpent, from: receipt.from, commitment: deposit.commitmentHex }
  } catch (e) {
    console.error('loadDepositData', e)
  }
  return {}
}
async function loadWithdrawalData({ amount, currency, deposit }) {
  try {
    const events = await await tornado.getPastEvents('Withdrawal', {
      fromBlock: 0,
      toBlock: 'latest'
    })

    const withdrawEvent = events.filter((event) => {
      return event.returnValues.nullifierHash === deposit.nullifierHex
    })[0]

    const fee = withdrawEvent.returnValues.fee
    const decimals = config.deployments[`netId${netId}`][currency].decimals
    const withdrawalAmount = toBN(fromDecimals({ amount, decimals })).sub(
      toBN(fee)
    )
    const { timestamp } = await web3.eth.getBlock(withdrawEvent.blockHash)
    return {
      amount: toDecimals(withdrawalAmount, decimals, 9),
      txHash: withdrawEvent.transactionHash,
      to: withdrawEvent.returnValues.to,
      timestamp,
      nullifier: deposit.nullifierHex,
      fee: toDecimals(fee, decimals, 9)
    }
  } catch (e) {
    console.error('loadWithdrawalData', e)
  }
}

/**
 * Init web3, contracts, and snark
 */
async function init({ rpc, noteNetId, token_address }) {
  let contractJson, voteTokenJson, erc20tornadoJson, tornadoAddress
  let tokenAddress = token_address
    // Initialize from local node
  web3 = new Web3(rpc, null, { transactionConfirmationBlocks: 1 })
  //contractJson = require('./build/contracts/ETHTornado.json')
  circuit = require('./build/circuits/withdraw.json')
  proving_key = fs.readFileSync('build/circuits/withdraw_proving_key.bin').buffer
  MERKLE_TREE_HEIGHT = process.env.MERKLE_TREE_HEIGHT || 20
  ETH_AMOUNT = process.env.ETH_AMOUNT
  TOKEN_AMOUNT = process.env.TOKEN_AMOUNT
  PRIVATE_KEY = process.env.PRIVATE_KEY_ROPSTEN
  if (PRIVATE_KEY) {
      const account = web3.eth.accounts.privateKeyToAccount('0x' + PRIVATE_KEY)
      web3.eth.accounts.wallet.add('0x' + PRIVATE_KEY)
      web3.eth.defaultAccount = account.address
      senderAccount = account.address

  } else {
      console.log('Warning! PRIVATE_KEY not found. Please provide PRIVATE_KEY in .env file if you deposit')
  }
  voteTokenJson = require('./build/contracts/VoteToken.json')
  erc20tornadoJson = require('./build/contracts/ERC20Tornado.json')

  // groth16 initialises a lot of Promises that will never be resolved, that's why we need to use process.exit to terminate the CLI
  groth16 = await buildGroth16()
  netId = await web3.eth.net.getId()
  if (noteNetId && Number(noteNetId) !== netId) {
    throw new Error('This note is for a different network. Specify the --rpc option explicitly')
  }
  console.log("NetId is ", netId)
  isLocalRPC = netId > 42

  if (isLocalRPC) {
    tornadoAddress = erc20tornadoJson.networks[netId].address
    //-------------------Here Account change ---------------------
    senderAccount = (await web3.eth.getAccounts())[0]
    console.log("Sender address ", senderAccount);
    console.log("tornadoAddress", tornadoAddress);
    console.log("Vote token address is ",tokenAddress);
    //registering the tornado contract address if not already happened
    try{
      await setAnonymityProviderAddress(tokenAddress, tornadoAddress, senderAccount);
    } catch(e){

      console.log(e);
    }

  } else {
    try {
      tornadoAddress = erc20tornadoJson.networks[netId].address


    } catch (e) {
      console.error('There is no such tornado instance')
      process.exit(1)
    }
  }

  tornado = new web3.eth.Contract(erc20tornadoJson.abi, tornadoAddress)
  voteToken =  new web3.eth.Contract(voteTokenJson.abi, tokenAddress)

}

async function vote({ vote_commitment_secret, relayerURL = 0, fee = 0, refund = 0 }, sender){

  //console.log("Your vote_commitment_secret is : ", vote_commitment_secret)
  if(sender) {
    senderAccount = sender
  }

if(relayerURL){
  let hash_secret = Buffer.from(web3.utils.hexToBytes(vote_commitment_secret))
  //let buf = Buffer.from(toHex(vote_commitment_secret))
  //  function _processVote(address payable _recipient, bytes20 _randomness, address payable _relayer, uint256 _fee, uint256 _refund) internal
  relayerAddress = '0x6bb38eed7Ca866D890550aDC0Ad79B723228Fb20'
  const args = [
    toHex(bigInt('0xB4F5663773fB2842d1A74B2da0b5ec95f2ac125A',"hex"),20),
    hash_secret,
    toHex(bigInt(relayerAddress,"hex"), 20),
    toHex(bigInt(fee)),
    toHex(bigInt(refund))
  ]
  console.log("Casting vote with relayer", relayerURL);
  console.log(args)
  let res = await axios.get('https://127.0.0.1:8000/', {
      httpsAgent: new https.Agent({
        rejectUnauthorized: false
      })
    })
  //console.log(res)

  try {
    const relay = await axios.post(relayerURL + '/relay', { address: tornado._address,args: args, type: "vote" }, {
        httpsAgent: new https.Agent({rejectUnauthorized: false })
      })
    if (netId === 1 || netId === 42) {
      console.log(`Transaction submitted through the relay. View transaction on etherscan https://${getCurrentNetworkName()}etherscan.io/tx/${relay.data.txHash}`)
    } else {
      console.log(`Transaction submitted through the relay. The transaction hash is ${relay.data.txHash}`)
    }
  } catch(e){
    console.log(e)
  }
}
else{
  let hash_secret = Buffer.from(web3.utils.hexToBytes(vote_commitment_secret))
  //let buf = Buffer.from(toHex(vote_commitment_secret))
  //  function _processVote(address payable _recipient, bytes20 _randomness, address payable _relayer, uint256 _fee, uint256 _refund) internal
  relayerAddress = '0x6bb38eed7Ca866D890550aDC0Ad79B723228Fb20'
  const args = [
    toHex(bigInt('0xB4F5663773fB2842d1A74B2da0b5ec95f2ac125A',"hex"),20),
    hash_secret,
    toHex(bigInt(relayerAddress,"hex"), 20),
    toHex(bigInt(fee)),
    toHex(bigInt(refund))
  ]
  console.log("Casting vote", senderAccount);
  // _processVote(address payable _recipient, bytes20 _randomness, address payable _relayer, uint256 _fee, uint256 _refund)
    await tornado.methods.vote(...args).send({ from: senderAccount, value: refund.toString(), gas: 1e6 })
      .on('transactionHash', function (txHash) {
        if (netId === 1 || netId === 42) {
          console.log(`View transaction on etherscan https://${getCurrentNetworkName()}etherscan.io/tx/${txHash}`)
        } else {
          console.log(`The transaction hash is ${txHash}`)
        }
      }).on('error', function (e) {
        console.error('on transactionHash error', e.message)
      })
}


}


async function setAnonymityProviderAddress(tokenAddress, mixAddress, senderAccount) {
  votetokenabi = new web3.eth.Contract(VoteTokenJson.abi, tokenAddress);
  var x = await votetokenabi.methods.anonymity_provider().call();
  if(x == '0x0000000000000000000000000000000000000000'){
    console.log("Setting anonymity provider")
    anonymity_provider = await votetokenabi.methods.setAnonymityProvider(mixAddress.toString()).send({ from: senderAccount.toString(), gasLimit: 2e6 });
    console.log(anonymity_provider)
    x = await votetokenabi.methods.anonymity_provider().call();
    console.log("set anonymity provider address to ", x);
  }

}


async function registerVoter(senderAccount, tokenAddress, toAccount) {
  //console.log("token address ", tokenAddress)
  console.log(web3.utils.isAddress(toAccount))
  console.log(senderAccount)

    voteToken = await new web3.eth.Contract(VoteTokenJson.abi, tokenAddress);
    let res = await voteToken.methods.transfer(toAccount,1).send({ from: senderAccount, gas: 5e6 })
    .on('transactionHash', function (txHash) {
      console.log(txHash);
    })

    return res;
}
async function advanceToNextPhase(nextPhaseBlock){
  console.log("Advancing to Block number", nextPhaseBlock)
  blocknr = await web3.eth.getBlockNumber();
  senderAccount = (await web3.eth.getAccounts())[0]

  while(nextPhaseBlock>= blocknr){

    web3.eth.sendTransaction({
        from: senderAccount,
        to: '0x0000000000000000000000000000000000000000',
        value: '1'
    })
    blocknr = await web3.eth.getBlockNumber();
  }
  console.log(blocknr)

}

async function main() {
  if (inBrowser) {
    const instance = { currency: 'eth', amount: '0.1' }
    await init(instance)
    window.deposit = async () => {
      await deposit(instance)
    }
    window.withdraw = async () => {
      const noteString = prompt('Enter the note to withdraw')
      const recipient = (await web3.eth.getAccounts())[0]

      const { netId, deposit } = parseNote(noteString)
      await init({ noteNetId: netId, currency })
      await withdraw({ deposit, currency, amount, recipient })
    }
  } else {
    program
      .option('-r, --rpc <URL>', 'The RPC, CLI should interact with', 'http://localhost:8545')
      .option('-R, --relayer <URL>', 'Interact via relayer')
      .option('-V, --vote <vote>', 'Specify the vote choice')
    program
      .command('deposit <token_address>')
      .description('Submit a deposit of specified currency and amount from default eth account and return the resulting note. The currency is one of (ETH|DAI|cDAI|USDC|cUSDC|USDT). The amount depends on currency, see config.js file or visit https://tornado.cash.')
      .action(async (token_address) => {
        await init({ rpc: program.rpc, token_address })
        await deposit()
      })
    program
      .command('commit <vote> <note> ')
      .description('commit a note to a recipient account using relayer or specified private key. You can exchange some of your deposit`s tokens to ETH during the withdrawal by specifing ETH_purchase (e.g. 0.01) to pay for gas in future transactions. Also see the --relayer option.')
      .action(async (vote, note) => {
        var netId = process.env.NET_ID
        let {token_address, deposit } = parseNote(note)

        await init({ rpc: program.rpc, noteNetId: netId, token_address });
        /*
        await sleep(2000)
        let note = await deposit(netId);


        console.log("Notes are: ", note)
        console.log("Sleeping for privacy")
        await sleep(2000)*/
            //Account 5 simulates the relayer
            //senderAccount = (await web3.eth.getAccounts())[5]

            console.log("Committing Account ", senderAccount)


            let refund = '0';
            success = false
            while(!success){
                try{
                  await commit({ deposit, vote, refund, relayerURL: program.relayer })
                  success = true
                } catch(e){
                  console.log("Commit failed nr ", i);
                  console.log(e)

                }
            }


      })
    program
      .command('balance <address> [token_address]')
      .description('Check ETH and ERC20 balance')
      .action(async (address, token_address) => {
        await init({ rpc: program.rpc, token_address})
        await printETHBalance({ address, name: '' })
        if (token_address) {
          await printERC20Balance({ address, name: '', token_address })
        }
      })
    program
      .command('vote <netId> <vote_commitment_secret> [ETH_purchase] ')
      .description("casts the vote included in the ")
      .action(async(netId, vote_commitment_secret, refund) => {
        await init({ rpc: program.rpc, noteNetId: netId})
        await vote({ vote_commitment_secret, refund, relayerURL: program.relayer })
      })


    program
      .command('test_ganache')
      .description('Perform an automated test. It conducts an election with 5 participants. Uses ganache.')
      .action(async () => {

        //Erc20 is deployed
        //Tornado is deployed
        console.log('Start Test Scenario with 5 Voters')
        web3 = new Web3(program.rpc, null, { transactionConfirmationBlocks: 1 })

        var  noteNetId = await web3.eth.net.getId()

        let token_address = VoteTokenJson.networks[noteNetId].address

        await init({ rpc: program.rpc, noteNetId,  token_address})
        //console.log(VoteTokenJson)
        console.log("NetId = ", netId)

        console.log("Token address: ", token_address)
        votetoken = await new web3.eth.Contract(VoteTokenJson.abi, token_address);
        console.log("------------ Distributing Vote Tokens ----------------")
        var blocknr =await web3.eth.getBlockNumber();
        console.log("Current Blocknr, ", blocknr)

        senderAccount = (await web3.eth.getAccounts())[0]
        console.log(senderAccount)
        for(var i = 1; i < 5; i++){
          let toAddress = (await web3.eth.getAccounts())[i]
          try{
            await registerVoter(senderAccount,token_address, toAddress);
          }catch{
            console.log("Tokens probably already distributed")
          }
          console.log("Address: ", toAddress)
          await printERC20Balance({ address: toAddress, name: '', token_address })
        }
        //let block = (await votetoken.methods.endphase1.call())
        await advanceToNextPhase(parseInt(blocknr)+parseInt(process.env.EndRegistrationPhase))
        let noteArray = new Array(5);
        let commitArray = new Array(5);
        console.log("------------ Starting Commit Round ----------------")
        blocknr =await web3.eth.getBlockNumber();
        console.log("Current Blocknr, ", blocknr)

        for(var i = 0; i < 5; i++){
          senderAccount = (await web3.eth.getAccounts())[i]
          console.log(senderAccount);
          try{
            noteArray[i] = await deposit(netId, senderAccount);
          }catch(e){
            console.log("Deposit failed nr ", i);
            console.log(e)
          }
        }
        console.log("Notes are: ", noteArray)

        //Account 5 simulates the relayer
        senderAccount = (await web3.eth.getAccounts())[5]

        for(var i = 0; i < 5; i++){
          console.log("Committing Account ", senderAccount)

          let { deposit } = parseNote(noteArray[i])
          let vote = 'yes';
          if(i > 2){
            vote = 'no';
          }
          let refund = '0';
          try{
            commitArray[i] = await commit({ deposit, vote, refund, relayerURL: program.relayer })
          } catch(e){
            console.log("Commit failed nr ", i);
            console.log(e)

          }
        }

        console.log("Commit Secrets are: ", noteArray)
        await advanceToNextPhase(parseInt(blocknr)+parseInt(process.env.EndCommitPhase))

        console.log("------------ Starting Cast Round ----------------")

        blocknr =await web3.eth.getBlockNumber();
        console.log("Current Blocknr, ", blocknr)
        for(var i = 0; i < 5; i++){
          //senderAccount = (await web3.eth.getAccounts())[5]
          console.log("Casting Account ", senderAccount)
          let { netId, deposit } = parseNote(noteArray[i])
          let vote_commitment_secret = commitArray[i];
          console.log("Submitting secret", commitArray[i]);
          let refund = 0;
          await vote({ vote_commitment_secret, refund, relayerURL: program.relayer })
        }
        console.log("\n------------ All votes are cast ----------------")
        console.log("The number of Yes votes are: ")
        let address = (await web3.eth.getAccounts())[9]


        await printERC20Balance({ address, name: '', token_address })
        console.log("The number of No votes are: ")
        address = (await web3.eth.getAccounts())[8]
        await printERC20Balance({ address, name: '', token_address })
        //console.log("Balance of relayer:")
        //console.log(senderAccount);
        //senderAccount = senderAccount.toString()
        //await printETHBalance({ senderAccount, name: '' })

      })


    program
      .command('register_local')
      .description('Registers 5 Participants locally. Uses ganache supplied addresses.')
      .action(async () => {

          //Erc20 is deployed
          //Tornado is deployed
          console.log('Registering 5 Voters on ganache')

          var currency = 'vote'
          var  amount = '1';
          var netId = '1337';
          let tokenAddress = VoteTokenJson.networks[netId].address
          console.log("Token address 2: ", tokenAddress)
          await init({ rpc: program.rpc })
          votetoken = await new web3.eth.Contract(VoteTokenJson.abi, tokenAddress);

          console.log("------------ Distributing Vote Tokens ----------------")
          var blocknr =await web3.eth.getBlockNumber();
          console.log("Current Blocknr, ", blocknr)

          senderAccount = (await web3.eth.getAccounts())[0]
          console.log(senderAccount)
          for(var i = 1; i < 5; i++){
            let toAddress = (await web3.eth.getAccounts())[i]
            console.log("Address: ", toAddress)
            try{
              await registerVoter(senderAccount,tokenAddress, toAddress);
            }catch{
              console.log("Tokens probably already distributed")
            }
            await printERC20Balance({ address: toAddress, name: '', tokenAddress })
          }
          //let block = (await votetoken.methods.endphase1.call())
          await advanceToNextPhase(parseInt(blocknr)+parseInt(process.env.EndRegistrationPhase))

    })


    program
      .command('init_and_register_testnet <voting_endowment_eth>')
      .description("Performs a test election on KOVAN testnet with an arbitrary number of participants as described in the env file supplies every participant with one votetoken and 0.07 eth for transaction fees")
      .action(async (voting_amount) => {


        console.log('Registering Voter voters on Testnet')
        var netId = process.env.NET_ID;
        var rpc = process.env.INFURA_KOVAN;
        web3 = await new Web3(rpc, null, { transactionConfirmationBlocks: 1 })
        const account = web3.eth.accounts.privateKeyToAccount('0x' + process.env.PRIVATE_KEY_ROPSTEN)
        web3.eth.accounts.wallet.add('0x' + process.env.PRIVATE_KEY_ROPSTEN)
        web3.eth.defaultAccount = account.address
        senderAccount = account.address;
        let tokenAddress = VoteTokenJson.networks[netId].address

        await init({ rpc: rpc, netId,  tokenAddress })


        votetoken = await new web3.eth.Contract(VoteTokenJson.abi, tokenAddress);

        erc20tornadoJson = require('./build/contracts/ERC20Tornado.json')
        tornadoAddress = erc20tornadoJson.networks[netId].address
        tornado = await new web3.eth.Contract(erc20tornadoJson.abi, tornadoAddress)


        console.log("Sender address ", senderAccount);
        console.log("tornadoAddress", tornadoAddress);
        console.log("Vote token address is ",tokenAddress);

        //registering the tornado contract address if not already done
        var success = false;

        try{
            var x = await votetoken.methods.anonymity_provider().call();
            console.log("anonymity provider address is ", x);
            if(x == '0x0000000000000000000000000000000000000000'){
              console.log("Setting anonymity provider")
              anonymity_provider = await votetoken.methods.setAnonymityProvider(tornadoAddress.toString()).send({ from: senderAccount, gasLimit: 2e6 });
              //console.log(anonymity_provider)
              x = await votetoken.methods.anonymity_provider().call();
              console.log("set anonymity provider address to ", x);
            }
        } catch(e){
            console.log(e);
        }

        var voter_array = []

        let participants_path = process.env.PARTICIPANTS_PATH
        try {
            // read contents of the file
            const data = fs.readFileSync(participants_path, 'UTF-8');

            // split the contents by new line
            const lines = data.split(/\r?\n/);

            // print all lines
            lines.forEach((line) => {
                //console.log(line);
                if(line != ''){
                  voter_array.push(line)

                }
            });
        } catch (err) {
            console.error(err);
        }


        var blocknr = await web3.eth.getBlockNumber();
        let block = blocknr + parseInt(process.env.EndRegistrationPhase)
        console.log("Current block", blocknr )
        console.log("Ende ",block )


        for(let i = 0; i < voter_array.length; i++) {
            console.log(`Registering ${i}th voter ${voter_array[i]}`);

            success = false;
            while (!success) {
              try {
                await web3.eth.sendTransaction({
                    from: senderAccount,
                    to: voter_array[i],
                    gasLimit: 2e6,
                    gasPrice: web3.utils.toHex(web3.utils.toWei('1', 'gwei')),
                    value: toWei(voting_amount.toString())
                }).on('transactionHash', function (txHash) {
                  console.log("ETH funding of new account txhash: ", txHash);
                })
                success = true
              } catch (e) {
                console.log(e);
              }
            }

            success = false;
            while (!success) {
                try{
                    console.log(`Sending 1 Votetoken from ${senderAccount} to ${voter_array[i]}`)
                    let res = await votetoken.methods.transfer(voter_array[i],1).send({ from: senderAccount, gas: 5e6 })
                    .on('transactionHash', function (txHash) {
                      console.log("Vote Token txhash: ", txHash);
                    })
                    success = true
                } catch(e){
                    console.log(e)
                    console.log("retrying, leftover balance sender: ")
                    await printERC20Balance({ address: senderAccount, name: '', tokenAddress })

                  }
              }
              await printERC20Balance({ address: voter_array[i], name: '', tokenAddress })
              await printETHBalance({ address: voter_array[i], name: '', tokenAddress })
            }


    })


    program
      .command('test_kovan')
      .description('Performs a test election on KOVAN testnet with an arbitrary number of participants as described in the .env file')
      .action(async () => {


        console.log('Registering Voter voters on Testnet')
        let voter_array = [];
        var currency = 'vote'
        var  amount = '1';
        var netId = process.env.NET_ID;
        var rpc = process.env.INFURA_KOVAN;
        web3 = await new Web3(rpc, null, { transactionConfirmationBlocks: 1 })
        const account = web3.eth.accounts.privateKeyToAccount('0x' + process.env.PRIVATE_KEY_ROPSTEN)


        web3.eth.accounts.wallet.add('0x' + process.env.PRIVATE_KEY_ROPSTEN)
        web3.eth.defaultAccount = account.address
        senderAccount = account.address;
        voter_array[0]= account;


        web3.eth.defaultAccount = senderAccount.address

        var netId = process.env.NET_ID;

        let tokenAddress = VoteTokenJson.networks[netId].address
        await init({ rpc: rpc, tokenAddress })

        console.log("Token address: ", tokenAddress)
        votetoken = await new web3.eth.Contract(VoteTokenJson.abi, tokenAddress);

        erc20tornadoJson = require('./build/contracts/ERC20Tornado.json')

        tornadoAddress = erc20tornadoJson.networks[netId].address
        tornado = await new web3.eth.Contract(erc20tornadoJson.abi, tornadoAddress)

        tokenAddress = VoteTokenJson.networks[netId].address

        console.log("Sender address ", senderAccount);
        console.log("tornadoAddress", tornadoAddress);
        console.log("Vote token address is ",tokenAddress);
        //registering the tornado contract address if not already happened
        var success = false;
        while (!success) {
          try{
            var x = await votetoken.methods.anonymity_provider().call();
            console.log("anonymity provider address is ", x);
            if(x == '0x0000000000000000000000000000000000000000'){
              console.log("Setting anonymity provider")
              anonymity_provider = await votetoken.methods.setAnonymityProvider(tornadoAddress.toString()).send({ from: senderAccount, gasLimit: 2e6 });
              //console.log(anonymity_provider)
              x = await votetoken.methods.anonymity_provider().call();
              console.log("set anonymity provider address to ", x);
              success = true;
            } else {
              success = true;
            }

          } catch(e){
            console.log(e);
          }
        }


        var blocknr = await web3.eth.getBlockNumber();
        let block = blocknr + parseInt(process.env.EndRegistrationPhase)
        console.log("BLock", blocknr )
        console.log("Ende ",block )


        for(let i = 1; i < parseInt(process.env.INITIAL_SUPPLY); i++) {

          voter_array[i]= web3.eth.accounts.create(["entropy"]);
          //voter_array[i]= web3.eth.accounts.privateKeyToAccount('0x' + process.env.PRIVATE_KEY_VOTER)
          web3.eth.accounts.wallet.add(voter_array[i])
        //await senderAccount.send({ value: toWei('0.01'), to: voter_array[i].address, gas: 2e6 })
        success = false;
        console.log("Sender Acoount", senderAccount);
        while (!success) {
          try {
            await web3.eth.sendTransaction({
                from: senderAccount,
                to: voter_array[i].address,
                gas: 2e6,
                gasPrice: web3.utils.toHex(web3.utils.toWei('1', 'gwei')),
                value: toWei('0.07')
            }).on('transactionHash', function (txHash) {
              console.log("ETH funding of new account txhash: ", txHash);
            })
            success = true
          } catch (e) {
            console.log(e);
          }
        }

        success = false;
        while (!success) {
            try{
                //await registerVoter(senderAccount,tokenAddress, voter_array[i].address);
                //console.log(tornado)
                console.log(`Sending to ${voter_array[i].address.toString()} from ${senderAccount}`)
                let res = await votetoken.methods.transfer(voter_array[i].address.toString(),1).send({ from: senderAccount, gas: 5e6 })
                .on('transactionHash', function (txHash) {
                  console.log("Vote Token txhash: ", txHash);
                })
                success = true
            } catch(e){
                console.log(e)
                console.log("Tokens probably already distributed")
              }
          }
          await printERC20Balance({ address: voter_array[i].address, name: '', tokenAddress })
          await printETHBalance({ address: voter_array[i].address, name: '', tokenAddress })
          }


          blocknr =await web3.eth.getBlockNumber();
          console.log("Current Block: ", blocknr)

          while(parseInt(blocknr) < parseInt(block)) {
              console.log("Waiting ", blocknr, parseInt(block))
              blocknr =await web3.eth.getBlockNumber();
              await sleep(2000);
            }

          let noteArray = new Array(parseInt(process.env.INITIAL_SUPPLY));
          let commitArray = new Array(parseInt(process.env.INITIAL_SUPPLY));
          console.log("------------ Starting Commit Round ----------------")
          blocknr =await web3.eth.getBlockNumber();
          console.log("Current Blocknr, ", blocknr)
          console.log(voter_array)

          for(var i = 0; i < parseInt(process.env.INITIAL_SUPPLY); i++){
              sender = voter_array[i].address

              web3.eth.defaultAccount = sender
              //senderAccount = web3.eth.defaultAccount
              console.log("Committing Sender Account ", sender);
              await printERC20Balance({ address: sender, name: '', tokenAddress })

              try{
                  noteArray[i] = await deposit(netId, sender);
              } catch(e) {
                  console.log("Deposit failed nr ", i);
                  console.log(e)
              }
          }
          console.log("Notes are: ", noteArray)

              //Account 5 simulates the relayer
              //senderAccount = (await web3.eth.getAccounts())[5]

          for(var i = 0; i < parseInt(process.env.INITIAL_SUPPLY); i++){
              console.log("Committing Account ", senderAccount)
              sender = voter_array[i].address
              web3.eth.defaultAccount = sender

              let { netId, deposit } = parseNote(noteArray[i])
              let vote = 'yes';
              if(i > 1){
                vote = 'no';
              }
              let refund = '0';
              success = false
              while(!success){
                  try{
                    commitArray[i] = await commit({ deposit, vote, refund, relayerURL: program.relayer }, sender)
                    success = true
                  } catch(e){
                    console.log("Commit failed nr ", i);
                    console.log(e)

                  }
              }

            }
            blocknr =await web3.eth.getBlockNumber();
            console.log("Current Block: ", blocknr)
            //await advanceToNextPhase(parseInt(blocknr)+parseInt(process.env.EndRegistrationPhase))
            //await advanceToNextPhase(parseInt(blocknr)+parseInt(process.env.EndCommitPhase))

            while(parseInt(blocknr) < parseInt(block)+parseInt(process.env.EndCommitPhase)) {
                console.log("Waiting ", blocknr, parseInt(block)+parseInt(process.env.EndCommitPhase))
                blocknr =await web3.eth.getBlockNumber();

                await sleep(2000);
            }

            console.log("------------ Starting Cast Round ----------------")
              //tornado is registered
            blocknr =await web3.eth.getBlockNumber();
            console.log("Current Blocknr, ", blocknr)
            for(var i = 0; i < parseInt(process.env.INITIAL_SUPPLY); i++){
                //senderAccount = (await web3.eth.getAccounts())[5]
                console.log("Casting Account ", senderAccount)
                sender = voter_array[i].address
                let { netId, deposit } = parseNote(noteArray[i])
                let vote_commitment_secret = commitArray[i];
                console.log("Submitting secret", commitArray[i]);
                let refund = 0;
                success = false
                while (!success) {
                  try {
                    await vote({ vote_commitment_secret, refund, relayerURL: program.relayer }, sender)
                    success = true
                  } catch (e) {
                    console.log(e)
                  }
                }
              }
            console.log("\n------------ All votes are cast ----------------")
            console.log("The number of Yes votes are: ")

            await printERC20Balance({ address: process.env.YES_ADDRESS, name: '', tokenAddress })
            console.log("The number of No votes are: ")
            await printERC20Balance({ address: process.env.NO_ADDRESS, name: '', tokenAddress })
    })


    program
      .command('advanceToVotePhase')
      .description('Advances to the vote phase in Ganache.')
      .action(async () => {
            var currency = 'vote'
            var  amount = '1';
            var netId = '1337';
            await init({ rpc: program.rpc })
            var blocknr =await web3.eth.getBlockNumber();
            await advanceToNextPhase(parseInt(blocknr)+parseInt(process.env.EndCommitPhase))
          })


    try {
      await program.parseAsync(process.argv)
      process.exit(0)
    } catch (e) {
      console.log('Error:', e)
      process.exit(1)
    }
  }
}

main()
