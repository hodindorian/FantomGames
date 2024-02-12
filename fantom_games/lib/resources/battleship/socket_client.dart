import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClientBattleShip {
  io.Socket? socket;
  static SocketClientBattleShip? _instance;

  /*
  SocketClient._internal() {
    socket = io.io('https://socketbattleship.fantomgames.eu', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
  }
  */

  SocketClientBattleShip._internal() {
    socket = io.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
  }




  static SocketClientBattleShip get instance {
    _instance ??= SocketClientBattleShip._internal();
    return _instance!;
  }
}