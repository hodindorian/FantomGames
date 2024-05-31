import 'package:fantom_games/model/battleship/global_room_battleship.dart';
import 'package:fantom_games/model/global_account.dart';
import 'package:fantom_games/resources/battleship/socket_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:mockito/mockito.dart';


class MockSocket extends Mock implements io.Socket {}
class MockRoomGlobalBattleShip extends Mock implements RoomGlobalBattleShip {}
class MockAccountGlobal extends Mock implements AccountGlobal {}

void main() {

  /*
  group('SocketMethodsBattleShip', () {
    late MockSocket mockSocket;
    late SocketMethodsBattleShip socketMethods;
    late MockRoomGlobalBattleShip mockRoomGlobal;
    late MockAccountGlobal mockAccountGlobal;
    late BuildContext mockContext;

    setUp(() {
      mockSocket = MockSocket();
      socketMethods = SocketMethodsBattleShip();
      mockRoomGlobal = MockRoomGlobalBattleShip();
      mockAccountGlobal = MockAccountGlobal();
      mockContext = BuildContext();
    });

    test('createRoom emits createRoom event with correct data', () {
      const String nickname = 'player1';
      socketMethods.createRoom(nickname);

      verify(mockSocket.emit('createRoom', {'nickname': nickname})).called(1);
    });

    test('joinRoom emits joinRoom event with correct data', () {
      const String nickname = 'player1';
      const String roomId = '1234';
      socketMethods.joinRoom(nickname, roomId);

      verify(mockSocket.emit('joinRoom', {'nickname': nickname, 'roomId': roomId})).called(1);
    });

    test('tapGrid emits tap event with correct data when displayElement is empty', () {
      const int index = 0;
      const String roomId = '1234';
      final List<String> displayElements = ['', '', '', '', '', '', '', '', '', ''];
      socketMethods.tapGrid(index, roomId, displayElements);

      verify(mockSocket.emit('tap', {'index': index, 'roomId': roomId})).called(1);
    });

    test('endGame emits endGame event and navigates to MainPage', () {
      when(mockRoomGlobal.roomData).thenReturn({'id': '1234'});

      socketMethods.endGame(mockContext);

      verify(mockSocket.emit('endGame', {'roomId': '1234'})).called(1);
      // Verify navigation
    });

    test('leaveGame emits leaveGame event', () {
      when(mockRoomGlobal.roomData).thenReturn({'id': '1234'});

      socketMethods.leaveGame(mockContext);

      verify(mockSocket.emit('leaveGame', {'roomId': '1234'})).called(1);
    });

    test('getBoats emits getBoats event with correct data', () {
      when(mockRoomGlobal.roomData).thenReturn({'id': '1234'});
      when(mockAccountGlobal.pseudo).thenReturn('player1');

      socketMethods.getBoats(mockContext);

      verify(mockSocket.emit('getBoats', {'player': 'player1', 'roomId': '1234'})).called(1);
    });

    // Tests for listeners
    test('createRoomSuccessListener listens for createRoomSuccess event', () {
      socketMethods.createRoomSuccessListener(mockContext);

      verify(mockSocket.on('createRoomSuccess', any)).called(1);
    });

    test('joinRoomSuccessListener listens for joinRoomSuccess event', () {
      socketMethods.joinRoomSuccessListener(mockContext);

      verify(mockSocket.on('joinRoomSuccess', any)).called(1);
    });

    test('errorOccuredListener listens for errorOccurred event', () {
      socketMethods.errorOccuredListener(mockContext);

      verify(mockSocket.on('errorOccurred', any)).called(1);
    });

    test('updateRoomListener listens for updateRoom event', () {
      socketMethods.updateRoomListener(mockContext);

      verify(mockSocket.on('updateRoom', any)).called(1);
    });

    test('tappedListener listens for tapped event', () {
      socketMethods.tappedListener(mockContext);

      verify(mockSocket.on('tapped', any)).called(1);
    });

    test('endGameListener listens for endGame event', () {
      socketMethods.endGameListener(mockContext);

      verify(mockSocket.on('endGame', any)).called(1);
    });

    test('leaveGameListener listens for leaveGame event', () {
      socketMethods.leaveGameListener(mockContext);

      verify(mockSocket.on('leaveGame', any)).called(1);
    });

    test('getBoatsListener listens for getBoats event', () {
      socketMethods.getBoatsListener(mockContext);

      verify(mockSocket.on('getBoats', any)).called(1);
    });
  });

   */
}
