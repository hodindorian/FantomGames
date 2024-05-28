import 'package:fantom_games/model/tic-tac-toe/global_room_tictactoe.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RoomGlobalTicTacToe tests', () {
    test('Updating room data', () {
      final room = RoomGlobalTicTacToe();
      final testData = {'exampleKey': 'exampleValue'};

      room.updateRoomData(testData);

      expect(room.roomData, testData);
    });

    test('Updating player 1', () {
      final room = RoomGlobalTicTacToe();
      final testPlayerData = {
        'nickname': 'testNickname',
        'socketID': 'testSocketID',
        'points': 5,
        'playerType': 'X',
      };

      room.updatePlayer1(testPlayerData);

      expect(room.player1.nickname, 'testNickname');
      expect(room.player1.socketID, 'testSocketID');
      expect(room.player1.points, 5);
      expect(room.player1.playerType, 'X');
    });

    test('Updating player 2', () {
      final room = RoomGlobalTicTacToe();
      final testPlayerData = {
        'nickname': 'testNickname',
        'socketID': 'testSocketID',
        'points': 3,
        'playerType': 'O',
      };

      room.updatePlayer2(testPlayerData);

      expect(room.player2.nickname, 'testNickname');
      expect(room.player2.socketID, 'testSocketID');
      expect(room.player2.points, 3);
      expect(room.player2.playerType, 'O');
    });

    test('Updating display elements', () {
      final room = RoomGlobalTicTacToe();

      room.updateDisplayElements(0, 'X');
      room.updateDisplayElements(1, 'O');
      room.updateDisplayElements(2, 'X');

      expect(room.displayElements, ['X', 'O', 'X', '', '', '', '', '', '']);
      expect(room.filledBoxes, 3);
    });

    test('Setting filled boxes to 0', () {
      final room = RoomGlobalTicTacToe();

      room.updateDisplayElements(0, 'X');
      room.updateDisplayElements(1, 'O');
      room.setFilledBoxesTo0();

      expect(room.displayElements, ['', '', '', '', '', '', '', '', '']);
      expect(room.filledBoxes, 0);
    });

    test('Resetting room', () {
      final room = RoomGlobalTicTacToe();

      room.updateDisplayElements(0, 'X');
      room.updatePlayer1({
        'nickname': 'testNickname1',
        'socketID': 'testSocketID1',
        'points': 5,
        'playerType': 'X',
      });
      room.updatePlayer2({
        'nickname': 'testNickname2',
        'socketID': 'testSocketID2',
        'points': 3,
        'playerType': 'O',
      });
      room.reset();

      expect(room.displayElements, ['', '', '', '', '', '', '', '', '']);
      expect(room.filledBoxes, 0);
      expect(room.player1.nickname, '');
      expect(room.player1.socketID, '');
      expect(room.player1.points, 0);
      expect(room.player1.playerType, 'X');
      expect(room.player2.nickname, '');
      expect(room.player2.socketID, '');
      expect(room.player2.points, 0);
      expect(room.player2.playerType, 'O');
    });
  });
}
