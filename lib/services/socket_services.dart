import 'package:socket_io_client/socket_io_client.dart'
as IO;

class SocketService {
  static final SocketService instance =
  SocketService._internal();
  late IO.Socket socket;
  SocketService._internal();
  
  void connect(){
    socket = IO.io(
      'http://192.168.1.9:3000',
      IO.OptionBuilder()
      .setTransports(['websocket'])
      .build(),
    );
    socket.connect();
    socket.onConnect((_) {
      print("SOCKET CONNECTED");
    });

    socket.on(
      'announcement:receive', 
      (data){
        print("DAPAT EVENT");
        print(data);
      }
    );
  }
  
  void sendAnnouncement(
    String message
  ){

    print("emit : $message");

    socket.emit(
      'announcement:send',
      {
        'message':message,
      },
    );
  }
}