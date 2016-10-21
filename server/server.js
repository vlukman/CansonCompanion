var WebSocketServer = require('ws').Server
  , wss = new WebSocketServer({ port: 3000 });

var listenerSocket = null;

wss.on('connection', function connection(socket) {
  console.log("connected " + socket);
  socket.on('message', function incoming(message) {
    if (message === 'knock') {
      if (listenerSocket != null) {
        listenerSocket.send("knock");
      }
    }
    else if (message === 'listener') {
      listenerSocket = socket;
      console.log("I am a listener app " + listenerSocket);
    }
    else {
      console.log('received: %s', message);
    }
  });

  // socket.send('something');
});