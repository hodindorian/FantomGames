import 'package:fantom_games/model/battleship/global_room_battleship.dart';
import 'package:test/test.dart';

void main() {
  group('RoomGlobalBattleShip', () {
    late RoomGlobalBattleShip room;

    setUp(() {
      room = RoomGlobalBattleShip();
    });

    test('updateRoomData should update _roomData and notify listeners', () {
      final newData = {'key': 'value'};
      bool notified = false;

      room.addListener(() {
        notified = true;
      });

      room.updateRoomData(newData);

      expect(room.roomData, equals(newData));
      expect(notified, isTrue);
    });

    test('updatePlayer1 should update player1 data and notify listeners', () {
      final player1Data = {
        'nickname': 'Player1',
        'socketID': '123',
        'nbPlayer': 1
      };
      bool notified = false;

      room.addListener(() {
        notified = true;
      });

      room.updatePlayer1(player1Data);

      expect(room.player1.nickname, equals('Player1'));
      expect(room.player1.socketID, equals('123'));
      expect(room.player1.nbPlayer, equals(1));
      expect(notified, isTrue);
    });

    test('updatePlayer2 should update player2 data and notify listeners', () {
      final player2Data = {
        'nickname': 'Player2',
        'socketID': '456',
        'nbPlayer': 2
      };
      bool notified = false;

      room.addListener(() {
        notified = true;
      });

      room.updatePlayer2(player2Data);

      expect(room.player2.nickname, equals('Player2'));
      expect(room.player2.socketID, equals('456'));
      expect(room.player2.nbPlayer, equals(2));
      expect(notified, isTrue);
    });

    test('updateDisplayElements1 should update display elements for player1 and notify listeners', () {
      bool notified = false;

      room.addListener(() {
        notified = true;
      });

      room.updateDisplayElements2(5, 'X');

      expect(room.displayElementsPlayer1[5], equals('X'));
      expect(notified, isTrue);
    });

    test('updateDisplayElements2 should update display elements for player2 and notify listeners', () {
      bool notified = false;

      room.addListener(() {
        notified = true;
      });

      room.updateDisplayElements1(5, 'O');

      expect(room.displayElementsPlayer2[5], equals('O'));
      expect(notified, isTrue);
    });

    test('reset should reset game state', () {
      room.endGame = true;
      room.winner = 'Player1';
      room.animation = true;

      room.reset();

      expect(room.endGame, isFalse);
      expect(room.winner, isEmpty);
      expect(room.animation, isFalse);
      expect(room.player1.nickname, isEmpty);
      expect(room.player2.nickname, isEmpty);
    });
    /*

    test('hitPlayer1 should correctly hit and update player1 boats', () {
      final boats = Boats();
      boats.createBoats([
        [[0, 0]],
        [[1, 1]],
        [[2, 2]],
        [[3, 3]],
        [[4, 4]],
        [[5, 5]]
      ]);
      room.updatePlayer1Boats(boats);

      room.hitPlayer1(0); // Hitting (0,0)

      expect(room.player1.boats.boat5.contains([0, 0]), isFalse);
    });

    test('hitPlayer2 should correctly hit and update player2 boats', () {
      final boats = Boats();
      boats.createBoats([
        [[0, 0]],
        [[1, 1]],
        [[2, 2]],
        [[3, 3]],
        [[4, 4]],
        [[5, 5]]
      ]);
      room.updatePlayer2Boats(boats);

      room.hitPlayer2(0); // Hitting (0,0)

      expect(room.player2.boats.boat5.contains([0, 0]), isFalse);
    });
    */
  });
}
