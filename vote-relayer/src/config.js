require('dotenv').config()

const { jobType } = require('./constants')
const tornConfig = require('torn-token')
module.exports = {
  netId: 1337,//Number(process.env.NET_ID) || 1,
  //redisUrl: process.env.REDIS_URL || 'redis://127.0.0.1:6379',
  //httpRpcUrl: process.env.HTTP_RPC_URL,
  //wsRpcUrl: process.env.WS_RPC_URL,
  //oracleRpcUrl: process.env.ORACLE_RPC_URL || 'https://mainnet.infura.io/',
  //offchainOracleAddress: '0x080AB73787A8B13EC7F40bd7d00d6CC07F9b24d0',
  //aggregatorAddress: process.env.AGGREGATOR,
  minerMerkleTreeHeight: 20,
  privateKey: process.env.PRIVATE_KEY,
  //instances: tornConfig.instances,
  //torn: tornConfig,
  port: process.env.APP_PORT || 8000,
  //tornadoServiceFee: Number(process.env.REGULAR_TORNADO_WITHDRAW_FEE),
  //miningServiceFee: Number(process.env.MINING_SERVICE_FEE),
  rewardAccount: process.env.REWARD_ACCOUNT,
  gasLimits: {
    [jobType.TORNADO_WITHDRAW]: 350000,
    [jobType.MINING_REWARD]: 455000,
    [jobType.MINING_WITHDRAW]: 400000,
  },
  minimumBalance: '1000000000000000000',
}
