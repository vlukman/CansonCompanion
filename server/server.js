/* jshint node:true */
"use strict";

var http = require('http');
var express = require('express'),
    app = module.exports.app = express();

var server = http.createServer(app);
var io = require('socket.io').listen(server);  //pass a http.Server instance
server.listen(3000);  //listen on port 3000

app.get('/', function (req, res) {
  res.send('hello world');
});

io.on('connection', function (socket) {
  console.log("isConnected " + socket.id);
  // socket.emit('news', { hello: 'world' });
  // socket.on('my other event', function (data) {
    // console.log(data);
  // });
});