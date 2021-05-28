const Web3 = require('web3')
var web3 = new Web3('HTTP://127.0.0.1:8545');
const erc20tornadoJson =  require('../contracts/ERC20Tornado.json')
const netId = 1337
async function relay(req, res){

  //console.log("Relay request received, ", req)
  const inputError = 0//getTornadoWithdrawInputError(req.body)
    if (inputError) {
      console.log('Invalid input:', inputError)
      return res.status(400).json({ error: inputError })
    }
    //let txId =0
    if(req.body.type == "commit"){
      console.log("Starting commit")
       await commit(req.body.proof, req.body.args, req.body.address)
       .then((txHash) => {
         console.log(txHash)
         res.json({txHash })
       })

    }
    else if( req.body.type == "vote"){
       await vote(req.body.args, req.body.address)
      .then((txHash) => {
        console.log(txHash)
        res.json({txHash })
      })
    }

}


async function commit(proof, args, tornadoAddress){
  //console.log(args);
  //let tornadoAddress = erc20tornadoJson.networks[netId].address
  //console.log("Tornado Contract Address: ", tornadoAddress)
  let tornado = new web3.eth.Contract(erc20tornadoJson.abi, tornadoAddress)
  let senderAccount = (await web3.eth.getAccounts())[7]
    let x = await tornado.methods.commit(proof, ...args).send({ from: senderAccount, gas: 1e6 })
      .on('transactionHash', function (txHash) {
        if (netId === 1 || netId === 42) {
          console.log(`View transaction on etherscan https://${getCurrentNetworkName()}etherscan.io/tx/${txHash}`)
        } else {
          console.log(`The transaction hash is ${txHash}`)
          return txHash;
        }
      }).on('error', function (e) {
        console.error('on transactionHash error', e.message)
        return e;
      })
}

async function vote(args,tornadoAddress){
  //let tornadoAddress = erc20tornadoJson.networks[netId].address
  //console.log("Tornado Contract Address: ", tornadoAddress)
  let tornado = new web3.eth.Contract(erc20tornadoJson.abi, tornadoAddress)

  let senderAccount = (await web3.eth.getAccounts())[7]
  //console.log(args)
  args[1] = Buffer.from(args[1])
  //console.log(args)
  let res
  await tornado.methods.vote(...args).send({ from: senderAccount, gas: 1e6 })
    .on('transactionHash', function (txHash) {
      if (netId === 1 || netId === 42) {
        console.log(`View transaction on etherscan https://${getCurrentNetworkName()}etherscan.io/tx/${txHash}`)
      } else {
        console.log(`The transaction hash is ${txHash}`)
        res = txHash
      }
    }).on('error', function (e) {
      console.error('on transactionHash error', e.message)
      res = e
    })
    return res
}

module.exports =  {relay}
