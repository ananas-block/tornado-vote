const express = require('express')
const relay = require('./relay.js')
//const { port, rewardAccount } = require('./config')
const { version } = require('../package.json')
const { isAddress } = require('web3-utils')
var http = require('http');
var https = require('https');
var fs = require('fs');


const app = express()
app.use(express.json())


require('https').globalAgent.options.ca = require('ssl-root-cas').create();

var sslOptions = {
  key: fs.readFileSync('src/ssl/key.pem'),
  cert: fs.readFileSync('src/ssl/cert.pem'),
  passphrase: 'vote-relayer',
};



// Add CORS headers
/*
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*')
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept')
  next()
})

// Log error to console but don't send it to the client to avoid leaking data

app.use((err, req, res, next) => {
  if (err) {
    console.error(err)
    return res.sendStatus(500)
  }
  next()
})*/
/*
app.get('/', status.index)
app.get('/v1/status', status.status)
app.get('/v1/jobs/:id', status.getJob)
app.post('/v1/tornadoWithdraw', controller.tornadoWithdraw)
app.get('/status', status.status)
*/

app.get('/', function (req, res) {
    res.send("Hello World!");
});


app.post('/relay', relay.relay)
//app.post('/v1/miningReward', controller.miningReward)
//app.post('/v1/miningWithdraw', controller.miningWithdraw)
/*
if (!isAddress(rewardAccount)) {
  throw new Error('No REWARD_ACCOUNT specified')
}*/
let port = 8000
//app.listen(port)
https.createServer(sslOptions, app).listen(port)


console.log(`Relayer ${version} started on port ${port}`)
