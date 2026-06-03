const express = require("express");
const http = require("http");
const { Server } = require("socket.io");

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
    cors: {
        origin: "*",
    },
});

io.on("connection", (socket) => {
    console.log("client connected");
    socket.on(
        "announcement:send",
        (data) => {
            io.emit(
                "announcement:receive",

    data,

   );

  }

 );

});

server.listen(

 3000,

 () => {

  console.log(
   "socket running 3000"
  );

 }

);