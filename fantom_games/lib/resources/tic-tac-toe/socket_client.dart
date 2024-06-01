import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClientTicTacToe {
  io.Socket? socket;
  static SocketClientTicTacToe? _instance;
  SocketClientTicTacToe._internal() {
    socket = io.io('https://sockettictactoe.fantomgames.eu', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
  }

  static SocketClientTicTacToe get instance {
    _instance ??= SocketClientTicTacToe._internal();
    return _instance!;
  }
}
