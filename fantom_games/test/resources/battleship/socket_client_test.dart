import 'package:fantom_games/resources/battleship/socket_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:mockito/mockito.dart';

class MockSocket extends Mock implements io.Socket {}

void main() {
  group('SocketClientBattleShip', () {
    test('singleton instance should be created', () {
      final instance1 = SocketClientBattleShip.instance;
      final instance2 = SocketClientBattleShip.instance;

      expect(instance1, isA<SocketClientBattleShip>());
      expect(instance2, isA<SocketClientBattleShip>());
      expect(instance1, same(instance2));
    });

    test('socket should be initialized and connected', () {
      final socketClient = SocketClientBattleShip.instance;
      expect(socketClient.socket, isNotNull);
    });

    test('socket should emit an event', () {
      final mockSocket = MockSocket();
      final socketClient = SocketClientBattleShip.instance;
      socketClient.socket = mockSocket;

      socketClient.socket!.emit('testEvent', {'key': 'value'});
      verify(mockSocket.emit('testEvent', {'key': 'value'})).called(1);
    });
  });
}
