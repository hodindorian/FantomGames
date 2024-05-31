import 'package:fantom_games/model/battleship/global_room_battleship.dart';
import 'package:fantom_games/resources/battleship/game_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:socket_io_client/socket_io_client.dart';

class MockSocket extends Mock implements Socket {}

void main() {
  group('GameMethodsBattleship', () {
    testWidgets('checkWinner detects player 2 as winner', (WidgetTester tester) async {
      final mockSocket = MockSocket();
      Map<String, dynamic> data = {
        'roomData': {'id': 'room1'},
        'endGame': false,
        'winner': 0
      };
      final RoomGlobalBattleShip roomGlobalBattleShip = RoomGlobalBattleShip();
      roomGlobalBattleShip.updateRoomData(data);
      final player1Data = {
        'nickname': 'Player1',
        'socketID': '123',
        'boats' : [[[],[],[],[],[],[]]],
      };
      final player2Data = {
        'nickname': 'Player2',
        'socketID': '456',
        'boats' : [[[0,1],[1,1],[1,2],[1,3],[1,4],[1,5]]],
      };
      roomGlobalBattleShip.updatePlayer1(player1Data);
      roomGlobalBattleShip.updatePlayer2(player2Data);
      roomGlobalBattleShip.actualPlayer =  roomGlobalBattleShip.player1;
      await tester.pumpWidget(
        ChangeNotifierProvider<RoomGlobalBattleShip>.value(
          value: roomGlobalBattleShip,
          child: MaterialApp(
            home: Builder(
              builder: (context) => Container(),
            ),
          ),
        ),
      );

      final gameMethodsBattleship = GameMethodsBattleship();

      gameMethodsBattleship.checkWinner(tester.element(find.byType(Container)), mockSocket);

      expect(roomGlobalBattleShip.winner, 2);
    });

    testWidgets('checkWinner detects player 1 as winner', (WidgetTester tester) async {
      final mockSocket = MockSocket();
      Map<String, dynamic> data = {
        'roomData': {'id': 'room1'},
        'endGame': false,
        'winner': 0
      };
      final RoomGlobalBattleShip roomGlobalBattleShip = RoomGlobalBattleShip();
      roomGlobalBattleShip.updateRoomData(data);
      final player1Data = {
        'nickname': 'Player1',
        'socketID': '123',
        'boats' : [[[0,1],[1,1],[1,2],[1,3],[1,4],[1,5]]],
      };
      final player2Data = {
        'nickname': 'Player2',
        'socketID': '456',
        'boats' : [[[],[],[],[],[],[]]],
      };
      roomGlobalBattleShip.updatePlayer1(player1Data);
      roomGlobalBattleShip.updatePlayer2(player2Data);
      roomGlobalBattleShip.actualPlayer =  roomGlobalBattleShip.player2;
      await tester.pumpWidget(
        ChangeNotifierProvider<RoomGlobalBattleShip>.value(
          value: roomGlobalBattleShip,
          child: MaterialApp(
            home: Builder(
              builder: (context) => Container(),
            ),
          ),
        ),
      );

      final gameMethodsBattleship = GameMethodsBattleship();

      gameMethodsBattleship.checkWinner(tester.element(find.byType(Container)), mockSocket);

      expect(roomGlobalBattleShip.winner, 1);
    });

    testWidgets('checkWinner does not declare a winner if game is not finished', (WidgetTester tester) async {
      final mockSocket = MockSocket();
      Map<String, dynamic> data = {
        'roomData': {'id': 'room1'},
        'endGame': false,
        'winner': 0
      };
      final RoomGlobalBattleShip roomGlobalBattleShip = RoomGlobalBattleShip();
      roomGlobalBattleShip.updateRoomData(data);
      final player1Data = {
        'nickname': 'Player1',
        'socketID': '123',
        'boats' : [[[0,1],[1,1],[1,2],[1,3],[1,4],[1,5]]],
      };
      final player2Data = {
        'nickname': 'Player2',
        'socketID': '456',
        'boats' : [[[0,1],[1,1],[1,2],[1,3],[1,4],[1,5]]],
      };
      roomGlobalBattleShip.updatePlayer1(player1Data);
      roomGlobalBattleShip.updatePlayer2(player2Data);
      roomGlobalBattleShip.actualPlayer =  roomGlobalBattleShip.player2;
      await tester.pumpWidget(
        ChangeNotifierProvider<RoomGlobalBattleShip>.value(
          value: roomGlobalBattleShip,
          child: MaterialApp(
            home: Builder(
              builder: (context) => Container(),
            ),
          ),
        ),
      );

      final gameMethodsBattleship = GameMethodsBattleship();

      gameMethodsBattleship.checkWinner(tester.element(find.byType(Container)), mockSocket);

      expect(roomGlobalBattleShip.winner, 0);
      verifyNever(mockSocket.emit('winner', any));
    });
  });
}
