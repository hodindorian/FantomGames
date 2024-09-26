import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClientBattleShip {
  io.Socket? socket;
  static SocketClientBattleShip? _instance;


  SocketClientBattleShip._internal() {
    socket = io.io('https://socketbattleship.hodindorian.com', <String, dynamic>{
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
