const Web3 = require('web3')
const fs = require('fs')
const process = require('process');
// Printing process.argv property value
require('dotenv').config()
let web3

//Number of blocks used
//which phase was how long
//blocks skipped

//number of transactions

//for every method gascosts, average, min, max, mean standard error

//zkp average, min, max, std error
function sum (array) {
  let sum = 0;
  for(var i in array) {
    sum += array[i];
  }
  return sum;
}

function max (array) {
  let max = 0;
  for(var i in array) {
    if (array[i] > max) {
      max = array[i]
    }
  }
  return max;
}

function min (array) {
  let min = Number.MAX_SAFE_INTEGER;
  for(var i in array) {
    if (array[i] < min) {
      min = array[i]
    }
  }
  return min;
}

function error(array) {
  let std_sum = 0
  let mean = parseFloat(sum(array)) / parseFloat(array.length)

  for(var i in array) {
    std_sum += (Math.pow((array[i] - mean), 2))
  }

  let std_dev = Math.sqrt(parseFloat((std_sum / (array.length)) ))
  return std_dev
}


async function main () {

  web3 = new Web3('HTTP://127.0.0.1:8545');
  let path = process.argv[2]



  let blocksnr =  []
  let block_usage = 0
  let gas_spent_in_phase = []

  let register = []
  let register_blocks = []

  let approve = []
  let approve_blocks = []

  let deposit = []
  let deposit_blocks = []

  let commit = []
  let commit_blocks = []

  let vote = []
  let vote_blocks = []

  let zkp_time =  []
  let total_zkp_time = []

  for (var j = 1; j < 2; j++ ) {
      let tmp = new Array(5)
      tmp[0] = []
      tmp[1] = []
      tmp[2] = []
      tmp[3] = []
      tmp[4] = []
      gas_spent_in_phase.push(tmp)
      blocksnr[j - 1] = []
      total_zkp_time[j - 1] = parseFloat(0)
      register_blocks[j - 1] = 0
      approve_blocks[j - 1] = 0
      deposit_blocks[j - 1] = 0
      commit_blocks[j - 1] = 0
      vote_blocks[j - 1] = 0
      // read contents of the file
      const data = fs.readFileSync(path + '/' + j + '.txt', 'UTF-8');

      // split the contents by new line
      const lines = data.split(/\r?\n/);

      // print all lines
      for (var i in lines) {
          //console.log(lines[i]);
          const words = lines[i].split(' ');
          //console.log(words)
          if(words[0] == 'register'){
              let tx = await web3.eth.getTransactionReceipt(words[3])
              //console.log(tx)
              register.push(tx.gasUsed)
              //console.log(register)
              //console.log(blocksnr.includes(tx.blockNumber))
              if (!blocksnr[j - 1].includes(tx.blockNumber)) {
                blocksnr[j - 1].push(tx.blockNumber)
                let block = await web3.eth.getBlock(tx.blockNumber)
                block_usage += await web3.utils.toDecimal(block.gasUsed)
                register_blocks[j - 1]++
                gas_spent_in_phase[j - 1][0].push(web3.utils.toDecimal(block.gasUsed))
                //console.log(`Register gascost block ${tx.blockNumber} ${web3.utils.toDecimal(tx.gasUsed)}`)
                //console.log(block)
              }

          } else if(words[0] == 'approve'){
              let tx = await web3.eth.getTransactionReceipt(words[3])
              //console.log(tx)
              approve.push(tx.gasUsed)

              //console.log(blocksnr.includes(tx.blockNumber))
              if (!blocksnr[j - 1].includes(tx.blockNumber)) {
                let block = await web3.eth.getBlock(tx.blockNumber)
                blocksnr[j - 1].push(tx.blockNumber)
                block_usage += web3.utils.toDecimal(block.gasUsed)
                approve_blocks[j - 1]++
                //console.log(`Gas used in approve block ${ web3.utils.toDecimal(block.gasUsed)}`)
                gas_spent_in_phase[j - 1][1].push(web3.utils.toDecimal(block.gasUsed))
              }
          } else if(words[0] == 'deposit'){
              let tx = await web3.eth.getTransactionReceipt(words[3])
              //console.log(tx)
              deposit.push(tx.gasUsed)
              //console.log(register)
              //console.log(blocksnr.includes(tx.blockNumber))
              if (!blocksnr[j - 1].includes(tx.blockNumber)) {
                let block = await web3.eth.getBlock(tx.blockNumber)
                blocksnr[j - 1].push(tx.blockNumber)
                block_usage += web3.utils.toDecimal(block.gasUsed)
                deposit_blocks[j - 1]++
                gas_spent_in_phase[j - 1][2].push(web3.utils.toDecimal(block.gasUsed))
              }
          } else if(words[0] == 'commit'){
              let tx = await web3.eth.getTransactionReceipt(words[3])
              //console.log(tx)
              commit.push(tx.gasUsed)
              //console.log(register)
              //console.log(blocksnr.includes(tx.blockNumber))
              if (!blocksnr[j - 1].includes(tx.blockNumber)) {
                let block = await web3.eth.getBlock(tx.blockNumber)
                blocksnr[j - 1].push(tx.blockNumber)
                block_usage += web3.utils.toDecimal(block.gasUsed)
                commit_blocks[j - 1]++
                gas_spent_in_phase[j - 1][3].push(web3.utils.toDecimal(block.gasUsed))
              }
          } else if(words[0] == 'vote'){
              let tx = await web3.eth.getTransactionReceipt(words[3])
              //console.log(tx)
              vote.push(tx.gasUsed)
              //console.log(register)
              //console.log(blocksnr.includes(tx.blockNumber))
              if (!blocksnr[j - 1].includes(tx.blockNumber)) {
                let block = await web3.eth.getBlock(tx.blockNumber)
                blocksnr[j - 1].push(tx.blockNumber)
                block_usage += web3.utils.toDecimal(block.gasUsed)
                vote_blocks[j - 1]++
                gas_spent_in_phase[j - 1][4].push(web3.utils.toDecimal(block.gasUsed))
              }
          } else if (words[0] == 'Proof' && words[1] == 'time:') {
              let tmp = words[2].split('')
              tmp = tmp.splice(0, tmp.length - 2).join('')//.replace(/ms/, '')

              //console.log(tmp)
              total_zkp_time[j - 1] = parseFloat(tmp) + parseFloat(total_zkp_time)
              zkp_time.push(parseFloat(tmp))
          }

      }
      for(var i in tmp) {
        console.log(`In phase ${i} gas consumption ${sum(tmp[i])}`)
      }
  }
  let register_average = (sum(register) / register.length)
  let register_max = max(register)
  let register_min = min(register)
  let register_error = error(register)

  let approve_average = (sum(approve) / approve.length)
  let approve_max = max(approve)
  let approve_min = min(approve)
  let approve_error = error(approve)

  let deposit_average = (sum(deposit) / deposit.length)
  let deposit_max = max(deposit)
  let deposit_min = min(deposit)
  let deposit_error = error(deposit)

  let commit_average = (sum(commit) / commit.length)
  let commit_max = max(commit)
  let commit_min = min(commit)
  let commit_error = error(commit)

  let vote_average = (sum(vote) / vote.length)
  let vote_max = max(vote)
  let vote_min = min(vote)
  let vote_error = error(vote)

  let zkp_average = (sum(zkp_time) / zkp_time.length)
  let zkp_max = max(zkp_time)
  let zkp_min = min(zkp_time)
  let zkp_error = error(zkp_time)
  let total_nr_blocks = 0
  console.log(`Register gas cost min ${register_min} max ${register_max} average ${register_average}, error ${register_error}, Blocks ${register_blocks}`)
  console.log(`approve gas cost min ${approve_min} max ${approve_max} average ${approve_average}, error ${approve_error},Blocks ${approve_blocks}`)
  console.log(`deposit gas cost min ${deposit_min} max ${deposit_max} average ${deposit_average}, error ${deposit_error},Blocks ${deposit_blocks}`)
  console.log(`commit gas cost min ${commit_min} max ${commit_max} average ${commit_average}, error ${commit_error},Blocks ${commit_blocks}`)
  console.log(`vote gas cost min ${vote_min} max ${vote_max} average ${vote_average}, error ${vote_error},Blocks ${vote_blocks}`)
  console.log(`ZKP min ${zkp_min} max ${zkp_max} average ${zkp_average}, error ${zkp_error}`)
  for(var i = 0; i < 10; i++){
    console.log(`Nr of Blocks with tx in election ${i + 1} : ${blocksnr[i].length}, ${blocksnr[i].sort()}`)
    console.log(`Average block usage ${(sum(gas_spent_in_phase[i][0]) + sum(gas_spent_in_phase[i][1]) + sum(gas_spent_in_phase[i][2]) + sum(gas_spent_in_phase[i][3]) + sum(gas_spent_in_phase[i][4]) )/ blocksnr[i].length}`)
    console.log(`block usage deposit ${(gas_spent_in_phase[i][2])}`)

    total_nr_blocks += blocksnr[i].length
    //console.log(`Gas used in registration phase ${(gas_spent_in_phase[i][0][1])}, approve ${(gas_spent_in_phase[i][1])}, deposit phase ${(gas_spent_in_phase[i][2])}, commit phase ${(gas_spent_in_phase[i][3])}, vote phase ${(gas_spent_in_phase[i][4])}`)
    console.log("\n")
  }
  console.log(`Total Average block usage ${block_usage / total_nr_blocks}`)
}

main()
