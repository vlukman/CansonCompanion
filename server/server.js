var WebSocketServer = require('ws').Server
  , wss = new WebSocketServer({ port: 3000 });

wss.on('connection', function connection(ws) {
  console.log("connected " + ws.id);
  ws.on('message', function incoming(message) {
    console.log('received: %s', message);
  });

  // ws.send('something');
});