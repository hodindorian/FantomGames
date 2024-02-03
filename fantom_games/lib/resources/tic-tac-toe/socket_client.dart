import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClient {
  io.Socket? socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    socket = io.io('https://sockettictactoe.fantomgames.eu', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
  }
  /*
  SocketClient._internal() {
    socket = io.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
  }
  */



  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
