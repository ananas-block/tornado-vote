/* global artifacts, web3, contract */


const fs = require('fs')

const { toWei, fromWei, toBN, BN } = require('web3-utils')

const { takeSnapshot, revertSnapshot } = require('../lib/ganacheHelper')

const VoteToken = artifacts.require('./VoteToken.sol')
const Tornado = artifacts.require('./ERC20Tornado.sol')
const erc20ContractJson = require('./../build/contracts/VoteToken.json')
const VoteTokenAddress = erc20ContractJson.networks[1337].address
const { ETH_AMOUNT, TOKEN_AMOUNT, MERKLE_TREE_HEIGHT,  FEE, YES_ADDRESS, NO_ADDRESS} = process.env
const VoteTokenJson = require('./../build/contracts/VoteToken.json')



const websnarkUtils = require('websnark/src/utils')
const buildGroth16 = require('websnark/src/groth16')
const stringifyBigInts = require('websnark/tools/stringifybigint').stringifyBigInts
const snarkjs = require('snarkjs')
const bigInt = snarkjs.bigInt
const crypto = require('crypto')
const circomlib = require('circomlib')
const MerkleTree = require('../lib/MerkleTree')

const rbigint = (nbytes) => snarkjs.bigInt.leBuff2int(crypto.randomBytes(nbytes))
const pedersenHash = (data) => circomlib.babyJub.unpackPoint(circomlib.pedersenHash.hash(data))[0]
const toFixedHex = (number, length = 32) =>  '0x' + bigInt(number).toString(16).padStart(length * 2, '0')
const getRandomRecipient = () => rbigint(20)
const Web3 = require('web3')
var web3 = new Web3('HTTP://127.0.0.1:8545');

function generateDeposit() {
  let deposit = {
    secret: rbigint(31),
    nullifier: rbigint(31),
  }
  const preimage = Buffer.concat([deposit.nullifier.leInt2Buff(31), deposit.secret.leInt2Buff(31)])
  deposit.commitment = pedersenHash(preimage)
  return deposit
}
async function setAnonymityProviderAddress(tokenAddress, mixAddress, senderAccount) {
  erc20 = new web3.eth.Contract(VoteTokenJson.abi, tokenAddress);

  var x = await erc20.methods.anonymity_provider().call();
  if(x == '0x0000000000000000000000000000000000000000'){
    anonymity_provider = await erc20.methods.setAnonymityProvider(mixAddress).send({ from: senderAccount, gas: 2e6 });
    x = await erc20.methods.anonymity_provider().call();
    console.log("set anonymity provider address to ", x);
  }

}
async function registerVoter(senderAccount,tokenAddress, toAccount) {
    erc20 = await new web3.eth.Contract(VoteTokenJson.abi, tokenAddress);
    let res = await erc20.methods.transfer(toAccount,1).send({ from: senderAccount, gas: 2e6 });
    return res;
}
async function advanceToNextPhase(nextPhaseBlock){
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
  //console.log(blocknr)

}

contract('VoteToken', accounts => {
  let tornado
  let token
  const sender = accounts[0]
  const operator = accounts[0]
  const levels = MERKLE_TREE_HEIGHT || 16
  let tokenDenomination = TOKEN_AMOUNT // 1 ether
  let snapshotId
  let prefix = 'test'
  let tree
  const fee = bigInt(web3.utils.toWei(FEE))//.shr(1) || bigInt(1e17)
  const refund = ETH_AMOUNT || '1000000000000000000' // 1 ether
  let recipient = getRandomRecipient()
  const relayer = accounts[7]
  let groth16
  let circuit
  let proving_key

  before(async () => {
    tree = new MerkleTree(
      levels,
      null,
      prefix,
    )
    votetoken = await VoteToken.deployed()
    tornado = await Tornado.deployed()
    await setAnonymityProviderAddress(votetoken.address, tornado.address, accounts[0])

    //badRecipient = await BadRecipient.new()
    snapshotId = await takeSnapshot()
    groth16 = await buildGroth16()
    circuit = require('../build/circuits/withdraw.json')
    proving_key = fs.readFileSync('build/circuits/withdraw_proving_key.bin').buffer
  })


  describe('#Registration Phase', () => {
    it('admin can register voters', async () => {
      erc20 = await new web3.eth.Contract(VoteTokenJson.abi, votetoken.address);
      //console.log("Balance of Account 0, ", await erc20.methods.balanceOf(accounts[0]).call())
      for (acc =1 ; acc < 2; acc++){
        await registerVoter(accounts[0],votetoken.address, accounts[acc]);
        let balance = await erc20.methods.balanceOf(accounts[acc]).call()
        //console.log(balance);
        balance.should.be.equal('1')
        //console.log("tranferred a voting token to ", accounts[acc]);
      }
    })

    it('admin can only transfer one token to a voter', async () => {
        await registerVoter(accounts[0],votetoken.address, accounts[1]);
        try{
          await registerVoter(accounts[0],votetoken.address, accounts[1]);
        }
        catch (err){
          err.message.should.be.equal('Returned error: VM Exception while processing transaction: revert Recepient already has a VoteToken');
        }
        try{
          await votetoken.transfer(accounts[1],2)
        }
        catch (err){
          err.reason.should.be.equal('Can only send one vote');
        }
    })
    it('admin cannot submit votes', async () => {

        //await registerVoter(accounts[0],votetoken.address, accounts[1]);
        erc20 = await new web3.eth.Contract(VoteTokenJson.abi, votetoken.address);
        //console.log("Balance of Account 1, ", await erc20.methods.balanceOf(accounts[1]).call())
        //console.log("Balance of Account 2, ", await erc20.methods.balanceOf(accounts[2]).call())

        try{
          await votetoken.transfer(accounts[8],1)
        }
        catch (err){
          err.reason.should.be.equal('Cannot cast no vote at this time');
        }
        try{
          await votetoken.transfer(accounts[9],1)
        }
        catch (err){
          err.reason.should.be.equal('Cannot cast yes vote at this time');
        }
    })
    it('voters cannot transfer tokens during registration', async () => {

        await registerVoter(accounts[0],votetoken.address, accounts[1]);
        erc20 = await new web3.eth.Contract(VoteTokenJson.abi, votetoken.address);
        //console.log("Balance of Account 1, ", await erc20.methods.balanceOf(accounts[1]).call())
        //console.log("Balance of Account 2, ", await erc20.methods.balanceOf(accounts[2]).call())

        web3.eth.defaultAccountC = accounts[1]
        try{
          await erc20.methods.transfer(accounts[7],1).send({from: accounts[1]})
        }
        catch (err){
          err.message.should.be.equal('Returned error: VM Exception while processing transaction: revert Only the administrator can distribute votes');
        }
    })
    it('commitphase cannot start if the admin has more than 1 token', async () => {
      //console.log("End Registration Phase is at Block", await votetoken.endphase1())
      advanceToNextPhase(await votetoken.endphase1())
      const commitment = toFixedHex(43)
      await votetoken.approve(tornado.address, tokenDenomination)
      //console.log("allowance : ", (await votetoken.allowance(accounts[0], tornado.address)).toString())
      //console.log("Balance of Account 0: ",(await votetoken.balanceOf(accounts[0])).toString())
      let blocknr = await web3.eth.getBlockNumber();
      //console.log(blocknr)
      //console.log(web3.utils.toWei(bigInt(2)* fee));
      try{
        let { logs } = await tornado.deposit(commitment, { from: accounts[0], value: toBN(2* web3.utils.toWei(FEE)) })
      }
      catch (err){
        err.reason.should.be.equal('Not successful, probably not enough allowed tokens');
        //logs[0].event.should.be.equal('Deposit')
        //logs[0].args.commitment.should.be.equal(commitment)
        //logs[0].args.leafIndex.should.be.eq.BN(0)
      }

    })

  })



  describe('#Commitment Phase', () => {

    it('deposit works', async () => {
      for (acc =1 ; acc < 5; acc++){
        await registerVoter(accounts[0],votetoken.address, accounts[acc]);
        //let balance = await erc20.methods.balanceOf(accounts[acc]).call()
        //console.log(balance);
        //balance.should.be.equal('1')
        //console.log("tranferred a voting token to ", accounts[acc]);
      }
      await advanceToNextPhase(await votetoken.endphase1())


      const commitment = toFixedHex(43)
      await votetoken.approve(tornado.address, tokenDenomination)
      //console.log("allowance : ", (await votetoken.allowance(accounts[0], tornado.address)).toString())
      //console.log("Balance of Account 0: ",(await votetoken.balanceOf(accounts[0])).toString())
      //let blocknr = await web3.eth.getBlockNumber();
      //console.log(blocknr)
      //console.log(web3.utils.toWei(bigInt(2)* fee));
      try{
        let { logs } = await tornado.deposit(commitment, { from: accounts[0], value: toBN(2* web3.utils.toWei(FEE)) })
      //console.log(logs);
      }
      catch (err){
        console.log(err)
      }
      //let balance_account_0 = (await votetoken.balanceOf(accounts[0])).toString()
      //console.log(balance_account_0)
      //balance_account_0.should.be.equal('0')

    })

    it('voters can only transfer to anonymity provider contract', async () => {

        for (acc =1 ; acc < 5; acc++){
          await registerVoter(accounts[0],votetoken.address, accounts[acc]);
          //let balance = await erc20.methods.balanceOf(accounts[acc]).call()
          //console.log(balance);
          //balance.should.be.equal('1')
          //console.log("tranferred a voting token to ", accounts[acc]);
        }
        await advanceToNextPhase(await votetoken.endphase1())

        erc20 = await new web3.eth.Contract(VoteTokenJson.abi, votetoken.address);
        //console.log("Balance of Account 1, ", await erc20.methods.balanceOf(accounts[1]).call())
        //console.log("Balance of Account 2, ", await erc20.methods.balanceOf(accounts[2]).call())

        try{
          await erc20.methods.transfer(accounts[7],1).send({from: accounts[1]})
        }
        catch (err){
          //console.log(err.message)
          err.message.should.be.equal('Returned error: VM Exception while processing transaction: revert Can only send vote to anonymity provider');
        }
    })

    it('should not allow to deposit with wrong fee', async () => {
      for (acc =1 ; acc < 5; acc++){
        await registerVoter(accounts[0],votetoken.address, accounts[acc]);
        //let balance = await erc20.methods.balanceOf(accounts[acc]).call()
        //console.log(balance);
        //balance.should.be.equal('1')
        //console.log("tranferred a voting token to ", accounts[acc]);
      }
      await advanceToNextPhase(await votetoken.endphase1())


      const commitment = toFixedHex(43)
      await votetoken.approve(tornado.address, tokenDenomination)
      //console.log("allowance : ", (await votetoken.allowance(accounts[0], tornado.address)).toString())
      //console.log("Balance of Account 0: ",(await votetoken.balanceOf(accounts[0])).toString())
      //let blocknr = await web3.eth.getBlockNumber();
      //console.log(blocknr)

      try{
        await tornado.deposit(commitment, { from: accounts[0], value: toBN(2* web3.utils.toWei('1')) })
      //console.log(logs);
      }
      catch (err){
        //console.log(err)
        err.reason.should.be.equal('ETH value is supposed to be double the fee, because two transactions of the relayer are necessary');
      }

    })

    it('commitment works and note can only be used once, casting vote not possible yet', async () => {
      for (acc =1 ; acc < 5; acc++){
        await registerVoter(accounts[0],votetoken.address, accounts[acc]);
        //console.log("tranferred a voting token to ", accounts[acc]);
      }
      await advanceToNextPhase(await votetoken.endphase1())


      const deposit = generateDeposit()
      await votetoken.approve(tornado.address, tokenDenomination)
      //console.log("allowance : ", (await votetoken.allowance(accounts[0], tornado.address)).toString())
      //console.log("Balance of Account 0: ",(await votetoken.balanceOf(accounts[0])).toString())
      //let blocknr = await web3.eth.getBlockNumber();
      //console.log(blocknr)
      //console.log(web3.utils.toWei(bigInt(2)* fee));
      try{
        await tornado.deposit(toFixedHex(deposit.commitment), { from: accounts[0], value: toBN(2* web3.utils.toWei(FEE)) })
        await tree.insert(deposit.commitment)
      }
      catch (err){
        console.log(err)
      }
      //let balance_account_0 = (await votetoken.balanceOf(accounts[0])).toString()
      //console.log(balance_account_0)

      //------------------------------------ Start Commitment Test -------------------------------------

      //generate vote commitment
      let vote_commitment_secret = rbigint(31)
      var vote_choice = new Uint8Array(1);
      vote_choice[0] = 1;
      var inst_arr = Buffer.from(vote_choice.buffer);
      const buf_t = Buffer.concat([vote_commitment_secret.leInt2Buff(31),inst_arr], 32 );
      let vote_commitment_hash = Web3.utils.sha3(buf_t)
      var buf = Buffer.from(web3.utils.hexToBytes(vote_commitment_hash))
      let slice = buf.slice(0, 20)
      vote_commitment_hash = web3.utils.bytesToHex(slice)
      recipient = vote_commitment_hash;


      const { root, path_elements, path_index } = await tree.path(0)
      // Circuit input
      const input = stringifyBigInts({
        // public
        root,
        nullifierHash: pedersenHash(deposit.nullifier.leInt2Buff(31)),
        relayer,
        recipient,
        fee,
        refund,

        // private
        nullifier: deposit.nullifier,
        secret: deposit.secret,
        pathElements: path_elements,
        pathIndices: path_index,
      })

      const proofData = await websnarkUtils.genWitnessAndProve(groth16, input, circuit, proving_key)
      const { proof } = websnarkUtils.toSolidityInput(proofData)

      const balanceTornadoBefore = await votetoken.balanceOf(tornado.address)
      //console.log("balanceTornadoBefore : ", balanceTornadoBefore);
      const balanceRelayerBefore = await votetoken.balanceOf(relayer)
      //console.log("balanceRelayerBefore : ", balanceRelayerBefore);
      //const balanceRecieverBefore = await votetoken.balanceOf(toFixedHex(recipient, 20))
      //console.log("balanceRecieverBefore : ", balanceRecieverBefore);
      const ethBalanceOperatorBefore = await web3.eth.getBalance(operator)
      //console.log("ethBalanceOperatorBefore : ", ethBalanceOperatorBefore);

      const ethBalanceRelayerBefore = await web3.eth.getBalance(relayer)
      //console.log("ethBalanceRelayerBefore : ", ethBalanceRelayerBefore);
      let isSpent = await tornado.isSpent(toFixedHex(input.nullifierHash))
      //console.log(isSpent)
      isSpent.should.be.equal(false)

      // Uncomment to measure gas usage
      // gas = await tornado.withdraw.estimateGas(proof, publicSignals, { from: relayer, gasPrice: '0' })
      // console.log('withdraw gas:', gas)
      const args = [
        toFixedHex(input.root),
        toFixedHex(input.nullifierHash),
        toFixedHex(input.recipient, 20),
        toFixedHex(input.relayer, 20),
        toFixedHex(input.fee),
        toFixedHex(input.refund)
      ]
      //console.log(args)
      //console.log("Proof", proof)
      //console.log("Refund", refund)
      ///console.log("Relayer", relayer)

      const { logs } = await tornado.commit(proof, ...args, { value: refund, from: relayer, gasPrice: '0' })
      //console.log(logs)

      const balanceTornadoAfter = await votetoken.balanceOf(tornado.address)
      const balanceRelayerAfter = await votetoken.balanceOf(relayer)
      const ethBalanceOperatorAfter = await web3.eth.getBalance(operator)
      const balanceRecieverAfter = await votetoken.balanceOf(toFixedHex(recipient, 20))
      const ethBalanceRecieverAfter = await web3.eth.getBalance(toFixedHex(recipient, 20))
      const ethBalanceRelayerAfter = await web3.eth.getBalance(relayer)
      const feeBN = toBN(fee.toString())
      balanceTornadoAfter.should.be.eq.BN(toBN(balanceTornadoBefore))
      //balanceRelayerAfter.should.be.eq.BN(toBN(balanceRelayerBefore).add(feeBN))
      //balanceRecieverAfter.should.be.eq.BN(toBN(balanceRecieverBefore).add(toBN(tokenDenomination).sub(feeBN)))

      //ethBalanceOperatorAfter.should.be.eq.BN(toBN(ethBalanceOperatorBefore))
      //ethBalanceRecieverAfter.should.be.eq.BN(toBN(ethBalanceRecieverBefore).add(toBN(refund)))
      //ethBalanceRelayerAfter.should.be.eq.BN(toBN(ethBalanceRelayerBefore).sub(toBN(refund)))

      //logs[0].event.should.be.equal('Withdrawal')
      //logs[0].args.nullifierHash.should.be.equal(toFixedHex(input.nullifierHash))
      //logs[0].args.relayer.should.be.eq.BN(relayer)
      //logs[0].args.fee.should.be.eq.BN(feeBN)
      isSpent = await tornado.isSpent(toFixedHex(input.nullifierHash))
      isSpent.should.be.equal(true)
      try{
        await tornado.commit(proof, ...args, { value: refund, from: relayer, gasPrice: '0' })
      }catch(err){
        err.reason.should.be.equal('The note has been already spent');

      }

      //Cast vote should not be possible in this Phase

      let hash_secret = buf
      //let buf = Buffer.from(toHex(vote_commitment_secret))
      //  function _processVote(address payable _recipient, bytes20 _randomness, address payable _relayer, uint256 _fee, uint256 _refund) internal
      const argsvote = [
        toFixedHex(bigInt('0xB4F5663773fB2842d1A74B2da0b5ec95f2ac125A',"hex"),20), //not used
        hash_secret,
        toFixedHex(input.relayer, 20),
        toFixedHex(input.fee),
        toFixedHex(input.refund)
      ]
      //console.log(argsvote)
      //console.log("refund", refund)
      //console.log("Casting vote", senderAccount);
      // _processVote(address payable _recipient, bytes20 _randomness, address payable _relayer, uint256 _fee, uint256 _refund)
      try{
        await tornado.vote(...argsvote, { value: refund, gas: 1e6 })

      }catch(err){
        err.reason.should.be.equal('Vote Period has not started yet');
      }





    })
  })


  describe('#Voting Phase', () => {
    it('vote casting works and hash can only be used once', async () => {
      for (acc =1 ; acc < 5; acc++){
        await registerVoter(accounts[0],votetoken.address, accounts[acc]);
        //console.log("tranferred a voting token to ", accounts[acc]);
      }
      await advanceToNextPhase(await votetoken.endphase1())
      const deposit = generateDeposit()
      await votetoken.approve(tornado.address, tokenDenomination)
      //console.log("allowance : ", (await votetoken.allowance(accounts[0], tornado.address)).toString())
      //console.log("Balance of Account 0: ",(await votetoken.balanceOf(accounts[0])).toString())
      //let blocknr = await web3.eth.getBlockNumber();
      //console.log(blocknr)
      //console.log(web3.utils.toWei(bigInt(2)* fee));
      try{
        await tornado.deposit(toFixedHex(deposit.commitment), { from: accounts[0], value: toBN(2* web3.utils.toWei(FEE)) })
        await tree.insert(deposit.commitment)
      }
      catch (err){
        console.log(err)
      }


      //------------------------------------ Start Commitment Test -------------------------------------

      //generate vote commitment
      let vote_commitment_secret = rbigint(31)
      var vote_choice = new Uint8Array(1);
      vote_choice[0] = 1;
      var inst_arr = Buffer.from(vote_choice.buffer);
      const buf_t = Buffer.concat([vote_commitment_secret.leInt2Buff(31),inst_arr], 32 );
      let vote_commitment_hash = Web3.utils.sha3(buf_t)
      var buf = Buffer.from(web3.utils.hexToBytes(vote_commitment_hash))
      let slice = buf.slice(0, 20)
      vote_commitment_hash = web3.utils.bytesToHex(slice)
      recipient = vote_commitment_hash;


      const { root, path_elements, path_index } = await tree.path(0)
      // Circuit input
      const input = stringifyBigInts({
        // public
        root,
        nullifierHash: pedersenHash(deposit.nullifier.leInt2Buff(31)),
        relayer,
        recipient,
        fee,
        refund,

        // private
        nullifier: deposit.nullifier,
        secret: deposit.secret,
        pathElements: path_elements,
        pathIndices: path_index,
      })

      const proofData = await websnarkUtils.genWitnessAndProve(groth16, input, circuit, proving_key)
      const { proof } = websnarkUtils.toSolidityInput(proofData)

      const balanceTornadoBefore = await votetoken.balanceOf(tornado.address)
      //console.log("balanceTornadoBefore : ", balanceTornadoBefore);
      const balanceRelayerBefore = await votetoken.balanceOf(relayer)
      //console.log("balanceRelayerBefore : ", balanceRelayerBefore);
      //const balanceRecieverBefore = await votetoken.balanceOf(toFixedHex(recipient, 20))
      //console.log("balanceRecieverBefore : ", balanceRecieverBefore);
      const ethBalanceOperatorBefore = await web3.eth.getBalance(operator)
      //console.log("ethBalanceOperatorBefore : ", ethBalanceOperatorBefore);

      const ethBalanceRelayerBefore = await web3.eth.getBalance(relayer)
      //console.log("ethBalanceRelayerBefore : ", ethBalanceRelayerBefore);
      let isSpent = await tornado.isSpent(toFixedHex(input.nullifierHash))
      //console.log(isSpent)
      isSpent.should.be.equal(false)

      // Uncomment to measure gas usage
      // gas = await tornado.withdraw.estimateGas(proof, publicSignals, { from: relayer, gasPrice: '0' })
      // console.log('withdraw gas:', gas)
      const args = [
        toFixedHex(input.root),
        toFixedHex(input.nullifierHash),
        toFixedHex(input.recipient, 20),
        toFixedHex(input.relayer, 20),
        toFixedHex(input.fee),
        toFixedHex(input.refund)
      ]

      await tornado.commit(proof, ...args, { value: refund, from: relayer, gasPrice: '0' })

      const balanceTornadoAfter = await votetoken.balanceOf(tornado.address)
      const balanceRelayerAfter = await votetoken.balanceOf(relayer)
      const ethBalanceOperatorAfter = await web3.eth.getBalance(operator)
      const balanceRecieverAfter = await votetoken.balanceOf(toFixedHex(recipient, 20))
      const ethBalanceRecieverAfter = await web3.eth.getBalance(toFixedHex(recipient, 20))
      const ethBalanceRelayerAfter = await web3.eth.getBalance(relayer)
      const feeBN = toBN(fee.toString())
      balanceTornadoAfter.should.be.eq.BN(toBN(balanceTornadoBefore))

      isSpent = await tornado.isSpent(toFixedHex(input.nullifierHash))
      isSpent.should.be.equal(true)

      //------------------------------------ Start Vote Casting Test -------------------------------------

      await advanceToNextPhase(await votetoken.endphase2())
      let hash_secret = buf_t
      //let buf = Buffer.from(toHex(vote_commitment_secret))
      //  function _processVote(address payable _recipient, bytes20 _randomness, address payable _relayer, uint256 _fee, uint256 _refund) internal
      const argsvote = [
        toFixedHex(bigInt('0xB4F5663773fB2842d1A74B2da0b5ec95f2ac125A',"hex"),20), //not used
        hash_secret,
        toFixedHex(input.relayer, 20),
        toFixedHex(input.fee),
        toFixedHex(input.refund)
      ]
      //console.log(argsvote)
      //console.log("refund", refund)
      //console.log("Casting vote", senderAccount);
      // _processVote(address payable _recipient, bytes20 _randomness, address payable _relayer, uint256 _fee, uint256 _refund)
      try{
        await tornado.vote(...argsvote, { value: refund, gas: 1e6 })
      }catch(err){
        console.log(err)
        //err.reason.should.be.equal('Vote Period has not started yet');
      }
      const balance_yes_votes = await votetoken.balanceOf(YES_ADDRESS)
      //console.log("Number of Yes votes ", balance_yes_votes)
      balance_yes_votes.should.be.eq.BN(1)
      const balanceTornadoAfterV = await votetoken.balanceOf(tornado.address)
      //console.log("balanceTornadoAfter ", balanceTornadoAfterV)
      balanceTornadoAfterV.should.be.eq.BN(0)
      try{
        await tornado.vote(...argsvote, { value: refund, gas: 1e6 })

      }catch(err){
        //console.log(err)
        err.reason.should.be.equal('Hash does not match any known hash');
      }
  })
})


  afterEach(async () => {
    await revertSnapshot(snapshotId.result)
    // eslint-disable-next-line require-atomic-updates
    snapshotId = await takeSnapshot()
    tree = new MerkleTree(
      levels,
      null,
      prefix,
    )
  })
})
