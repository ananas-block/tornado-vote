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
const voteerc = require('../VoteErc20/script.js')

let web3, tornado, circuit, proving_key, groth16, erc20, senderAccount, netId
let MERKLE_TREE_HEIGHT, ETH_AMOUNT, TOKEN_AMOUNT, PRIVATE_KEY

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
  const erc20ContractJson = require('./build/contracts/ERC20Mock.json')
  erc20 = tokenAddress ? new web3.eth.Contract(erc20ContractJson.abi, tokenAddress) : erc20
  console.log(`${name} Token Balance is`, await erc20.methods.balanceOf(address).call())//web3.utils.fromWei(await erc20.methods.balanceOf(address).call()))
  //console.log(`${name} Token Decimals is`, await erc20.methods.decimals().call())//web3.utils.fromWei(await erc20.methods.balanceOf(address).call()))
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
async function deposit({ currency, amount }) {

  const deposit = createDeposit({ nullifier: rbigint(31), secret: rbigint(31)})
  const note = toHex(deposit.preimage, 62)
  const noteString = `tornado-${currency}-${amount}-${netId}-${note}`

  console.log(`Your note: ${noteString}`)
  //console.log("Your randomness is :", randomness);
  //console.log("Your Commitment is :", commit);
  /*
  if (currency === 'eth') {
    await printETHBalance({ address: tornado._address, name: 'Tornado' })
    await printETHBalance({ address: senderAccount, name: 'Sender account' })
    const value = isLocalRPC ? ETH_AMOUNT : fromDecimals({ amount, decimals: 18 })
    console.log('Submitting deposit transaction')
    await tornado.methods.deposit(toHex(deposit.commitment)).send({ value, from: senderAccount, gas: 2e6 })
    await printETHBalance({ address: tornado._address, name: 'Tornado' })
    await printETHBalance({ address: senderAccount, name: 'Sender account' })
  } else { // a token*/
    await printERC20Balance({ address: tornado._address, name: 'Tornado' })
    await printERC20Balance({ address: senderAccount, name: 'Sender account' })
    const decimals = await erc20.methods.decimals().call();//isLocalRPC ? 18 : config.deployments[`netId${netId}`][currency].decimals
    const tokenAmount = isLocalRPC ? TOKEN_AMOUNT : fromDecimals({ amount, decimals })
    //console.log(decimals);

    //const tokenAmount = amount;
    /*
    if (isLocalRPC) {
      console.log('Minting some test tokens to deposit')
      await erc20.methods.mint(senderAccount, tokenAmount).send({ from: senderAccount, gas: 2e6 })
    }*/

    const allowance = await erc20.methods.allowance(senderAccount, tornado._address).call({ from: senderAccount })
    console.log('Current allowance is', allowance)
    //console.log(tokenAmount)
    //if (toBN(allowance).lt(toBN(tokenAmount))) {
      console.log('Approving tokens for deposit', tokenAmount)
      var x = await erc20.methods.approve(tornado._address, tokenAmount).send({ from: senderAccount, gas: 1e6 })
    //}
    //console.log("approval : ",x)
    console.log('Submitting deposit transaction')
    var res = await tornado.methods.deposit(toHex(deposit.commitment)).send({ from: senderAccount, gas: 2e6 })
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
async function commit({ deposit,vote, currency, amount, relayerURL, refund = '0' }) {
  if (currency === 'eth' && refund !== '0') {
    throw new Error('The ETH purchase is supposted to be 0 for ETH withdrawals')
  }
  refund = toWei(refund)
  /*
  if (relayerURL) {
    if (relayerURL.endsWith('.eth')) {
      throw new Error('ENS name resolving is not supported. Please provide DNS name of the relayer. See instuctions in README.md')
    }
    const relayerStatus = await axios.get(relayerURL + '/status')
    console.log(relayerStatus)
    var { relayerAddress, netId, gasPrices, ethPrices, tornadoServiceFee } = relayerStatus.data
    //20000000000
    assert(netId === await web3.eth.net.getId() || netId === '*', 'This relay is for different network')
    relayerAddress = '0'
    gasPrices = fromWei('20000000000')
    //tornadoServiceFee = toWei('0.1') * 0.05
    console.log('Relay url ',  relayerAddress, netId, gasPrices, ethPrices, tornadoServiceFee)
    //console.log('Relay address: ', relayerAddress)

    const decimals = isLocalRPC ? 18 : config.deployments[`netId${netId}`][currency].decimals
    const fee = calculateFee({ gasPrices, currency, amount, refund, ethPrices, tornadoServiceFee, decimals })

    console.log('Relay url ', relayerAddress)

    if (fee.gt(fromDecimals({ amount, decimals }))) {
      throw new Error('Too high refund')
    }

    const { proof, args } = await generateProof({ deposit, recipient, relayerAddress, fee, refund })
    console.log(proof);
    console.log(args);
    console.log('Sending commit transaction through relay',  tornado._address)
    try {
      const relay = await axios.post(relayerURL + '/relay', { contract: tornado._address, proof, args })
      if (netId === 1 || netId === 42) {
        console.log(`Transaction submitted through the relay. View transaction on etherscan https://${getCurrentNetworkName()}etherscan.io/tx/${relay.data.txHash}`)
      } else {
        console.log(`Transaction submitted through the relay. The transaction hash is ${relay.data.txHash}`)
      }

      const receipt = await waitForTxReceipt({ txHash: relay.data.txHash })
      console.log('Transaction mined in block', receipt.blockNumber)
    } catch (e) {
      if (e.response) {
        console.error(e.response.data.error)
      } else {
        console.error(e.message)
      }
    }
  } else { // using private key */
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
    const { proof, args } = await generateProof({ deposit, recipient, refund })
  /*Test whether I can change the hash, I can t
    let vote_commitment_secret2 = rbigint(20)
    buf = Buffer.from(vote_commitment_secret2.leInt2Buff(20))

    args[2] = toHex(buf, 20)
    console.log(args[2]);
    */
    console.log('Submitting commit transaction from ', senderAccount);

    //console.log(args);
    //console.log("Sha3 hash buffer ", Buffer.from(buf.slice(0, 20)));
    //console.log("args hash buffer ", Buffer.from(bigInt(args[2]).leInt2Buff(20)));
    //args[2] = Buffer.from(bigInt(args[2]).leInt2Buff(20))
    //args.splice(3,0, buf_t);
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
  //}
  //console.log(x.events.Commit.returnValues)
  console.log('Done')
  return web3.utils.bytesToHex(buf_t);
  //console.log(Buffer.from(x.events.Commit.returnValues[0]))
  //console.log(Buffer.from(x.events.Commit.returnValues[1]))


}

function fromDecimals({ amount, decimals }) {
  amount = amount.toString()
  let ether = amount.toString()
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
  const noteRegex = /tornado-(?<currency>\w+)-(?<amount>[\d.]+)-(?<netId>\d+)-0x(?<note>[0-9a-fA-F]{124})/g
  const match = noteRegex.exec(noteString)
  if (!match) {
    throw new Error('The note has invalid format')
  }

  const buf = Buffer.from(match.groups.note, 'hex')
  const nullifier = bigInt.leBuff2int(buf.slice(0, 31))
  const secret = bigInt.leBuff2int(buf.slice(31, 62))
  const deposit = createDeposit({ nullifier, secret })
  const netId = Number(match.groups.netId)

  return { currency: match.groups.currency, amount: match.groups.amount, netId, deposit }
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
async function init({ rpc, noteNetId, currency = 'dai', amount = '100' }) {
  let contractJson, erc20ContractJson, erc20tornadoJson, tornadoAddress, tokenAddress
  // TODO do we need this? should it work in browser really?
  if (inBrowser) {
    // Initialize using injected web3 (Metamask)
    // To assemble web version run `npm run browserify`
    web3 = new Web3(window.web3.currentProvider, null, { transactionConfirmationBlocks: 1 })
    //contractJson = await (await fetch('build/contracts/ETHTornado.json')).json()
    circuit = await (await fetch('build/circuits/withdraw.json')).json()
    proving_key = await (await fetch('build/circuits/withdraw_proving_key.bin')).arrayBuffer()
    MERKLE_TREE_HEIGHT = 20
    ETH_AMOUNT = 1e18
    TOKEN_AMOUNT = 1e19
    senderAccount = (await web3.eth.getAccounts())[0]
  } else {
    // Initialize from local node
    web3 = new Web3(rpc, null, { transactionConfirmationBlocks: 1 })
    //contractJson = require('./build/contracts/ETHTornado.json')
    circuit = require('./build/circuits/withdraw.json')
    proving_key = fs.readFileSync('build/circuits/withdraw_proving_key.bin').buffer
    MERKLE_TREE_HEIGHT = process.env.MERKLE_TREE_HEIGHT || 20
    ETH_AMOUNT = process.env.ETH_AMOUNT
    TOKEN_AMOUNT = process.env.TOKEN_AMOUNT
    PRIVATE_KEY = process.env.PRIVATE_KEY2
    if (PRIVATE_KEY) {
      //console.log("PRivate KEy: ",PRIVATE_KEY)

      const account = web3.eth.accounts.privateKeyToAccount('0x' + PRIVATE_KEY)
      web3.eth.accounts.wallet.add('0x' + PRIVATE_KEY)
      web3.eth.defaultAccount = account.address
      senderAccount = account.address
      //console.log(account)
    } else {
      console.log('Warning! PRIVATE_KEY not found. Please provide PRIVATE_KEY in .env file if you deposit')
    }
    erc20ContractJson = require('./build/contracts/ERC20.json')
    erc20tornadoJson = require('./build/contracts/ERC20Tornado.json')
  }
  // groth16 initialises a lot of Promises that will never be resolved, that's why we need to use process.exit to terminate the CLI
  groth16 = await buildGroth16()
  netId = await web3.eth.net.getId()
  if (noteNetId && Number(noteNetId) !== netId) {
    throw new Error('This note is for a different network. Specify the --rpc option explicitly')
  }
  isLocalRPC = netId > 42

  if (isLocalRPC) {
    tornadoAddress = erc20tornadoJson.networks[netId].address
    tokenAddress = process.env.ERC20_TOKEN //currency !== 'eth' ? erc20ContractJson.networks[netId].address : null
    //-------------------Here Account change ---------------------
    senderAccount = (await web3.eth.getAccounts())[0]
    console.log("Sender address ", senderAccount);
    console.log("tornadoAddress", tornadoAddress);
    console.log("VOte token address is ",tokenAddress);
    //registering the tornado contract address if not already happened
    try{
      await voteerc.setMixcontractAddress(process.env.ERC20_TOKEN, tornadoAddress, senderAccount);
    } catch(e){
      console.log(e);
    }

  } else {
    try {
      tornadoAddress = config.deployments[`netId${netId}`][currency].instanceAddress[amount]
      if (!tornadoAddress) {
        throw new Error()
      }
      tokenAddress = config.deployments[`netId${netId}`][currency].tokenAddress
    } catch (e) {
      console.error('There is no such tornado instance, check the currency and amount you provide')
      process.exit(1)
    }
  }
  tornado = new web3.eth.Contract(erc20tornadoJson.abi, tornadoAddress)
  //console.log(tornado);
  erc20 = currency !== 'eth' ? new web3.eth.Contract(erc20ContractJson.abi, tokenAddress) : {}
}

async function vote({ vote_commitment_secret, relayerAddress = 0, fee = 0, refund = 0 }){

  //console.log("Your vote_commitment_secret is : ", vote_commitment_secret)

  let hash_secret = Buffer.from(web3.utils.hexToBytes(vote_commitment_secret))
  //let buf = Buffer.from(toHex(vote_commitment_secret))
//  function _processVote(address payable _recipient, bytes20 _randomness, address payable _relayer, uint256 _fee, uint256 _refund) internal
const args = [
  toHex(bigInt('0xB4F5663773fB2842d1A74B2da0b5ec95f2ac125A',"hex"),20),
  hash_secret,
  toHex(bigInt(relayerAddress), 20),
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

      const { currency, amount, netId, deposit } = parseNote(noteString)
      await init({ noteNetId: netId, currency, amount })
      await withdraw({ deposit, currency, amount, recipient })
    }
  } else {
    program
      .option('-r, --rpc <URL>', 'The RPC, CLI should interact with', 'http://localhost:8545')
      .option('-R, --relayer <URL>', 'Interact via relayer')
    program
      .command('deposit <currency> <amount>')
      .description('Submit a deposit of specified currency and amount from default eth account and return the resulting note. The currency is one of (ETH|DAI|cDAI|USDC|cUSDC|USDT). The amount depends on currency, see config.js file or visit https://tornado.cash.')
      .action(async (currency, amount) => {
        currency = currency.toLowerCase()
        await init({ rpc: program.rpc, currency, amount })
        await deposit({ currency, amount })
      })
    program
      .command('commit <note> <recipient> <vote> [ETH_purchase]')
      .description('commit a note to a recipient account using relayer or specified private key. You can exchange some of your deposit`s tokens to ETH during the withdrawal by specifing ETH_purchase (e.g. 0.01) to pay for gas in future transactions. Also see the --relayer option.')
      .action(async (noteString, vote, recipient, refund) => {
        const { currency, amount, netId, deposit } = parseNote(noteString)
        await init({ rpc: program.rpc, noteNetId: netId, currency, amount })
        await commit({ deposit, vote, currency, amount, recipient, refund, relayerURL: program.relayer })
      })
    program
      .command('balance <address> [token_address]')
      .description('Check ETH and ERC20 balance')
      .action(async (address, tokenAddress) => {
        await init({ rpc: program.rpc })
        await printETHBalance({ address, name: '' })
        if (tokenAddress) {
          await printERC20Balance({ address, name: '', tokenAddress })
        }
      })
    program
      .command('vote <note> <vote_commitment_secret> [ETH_purchase] ')
      .description("casts the vote included in the ")
      .action(async(noteString, vote_commitment_secret, refund) => {
        const { currency, amount, netId, deposit } = parseNote(noteString)
        await init({ rpc: program.rpc, noteNetId: netId, currency, amount })
        await vote({ vote_commitment_secret, currency, amount, refund, relayerURL: program.relayer })
      })


    program
      .command('test')
      .description('Perform an automated test. It deposits and withdraws one ETH and one ERC20 note. Uses ganache.')
      .action(async () => {

        //Erc20 is deployed
        //Tornado is deployed
        console.log('Start Test Scenario with 5 Voters')
        var currency = 'vote'
        var  amount = '1';
        var netId = '1337';
        await init({ rpc: program.rpc, currency, amount })
        let noteArray = new Array(5);
        let commitArray = new Array(5);
        console.log("------------ Starting Commit Round ----------------")

        for(var i = 0; i < 5; i++){
          senderAccount = (await web3.eth.getAccounts())[i]
          console.log(senderAccount);
          try{
            noteArray[i] = await deposit({ currency, amount });
          }catch(e){
            console.log("Deposit failed nr ", i);
            console.log(e)
          }
        }
        console.log("Notes are: ", noteArray)


        for(var i = 0; i < 5; i++){
          senderAccount = (await web3.eth.getAccounts())[i]
          console.log("Committing Account ", senderAccount)

          let { currency, amount, netId, deposit } = parseNote(noteArray[i])
          let vote = 'yes';
          if(i > 2){
            vote = 'no';
          }
          let refund = '0';
          try{
            commitArray[i] = await commit({ deposit, vote, currency, amount, refund, relayerURL: program.relayer })
          } catch(e){
            console.log("Commit failed nr ", i);
            console.log(e)

          }
        }

        console.log("Commit Secrets are: ", noteArray)

        await voteerc.advanceBlocks(200, senderAccount);
        console.log("------------ Advanced 200 Blocks ----------------")
        console.log("------------ Starting Cast Round ----------------")
        //tornado is registered
        for(var i = 0; i < 5; i++){
          senderAccount = (await web3.eth.getAccounts())[i]
          console.log("Casting Account ", senderAccount)
          let { currency, amount, netId, deposit } = parseNote(noteArray[i])
          let vote_commitment_secret = commitArray[i];
          console.log("Submitting secret", vote_commitment_secret);
          let refund = 0;
          await vote({ vote_commitment_secret, currency, amount, refund, relayerURL: program.relayer })
        }
        console.log("\n------------ All votes are cast ----------------")
        console.log("The number of Yes votes are: ")
        let address = (await web3.eth.getAccounts())[9]
        let tokenAddress = process.env.ERC20_TOKEN
        await printERC20Balance({ address, name: '', tokenAddress })
        console.log("The number of No votes are: ")
        address = (await web3.eth.getAccounts())[8]
        await printERC20Balance({ address, name: '', tokenAddress })
        /*
        await withdraw({ deposit: parsedNote.deposit, currency, amount, recipient: senderAccount, relayerURL: program.relayer })

        console.log('\nStart performing DAI deposit-withdraw test')
        currency = 'dai'
        amount = '100'
        await init({ rpc: program.rpc, currency, amount })
        noteString = await deposit({ currency, amount })
        (parsedNote = parseNote(noteString))
        await withdraw({ deposit: parsedNote.deposit, currency, amount, recipient: senderAccount, refund: '0.02', relayerURL: program.relayer })
        */
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
