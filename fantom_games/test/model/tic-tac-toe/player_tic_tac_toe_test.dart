import 'package:flutter_test/flutter_test.dart';
import 'package:fantom_games/model/tic-tac-toe/player_tic_tac_toe.dart';

void main() {
  group('PlayerTicTacToe tests', () {
    test('Creating PlayerTicTacToe instance', () {
      final player = PlayerTicTacToe(
        nickname: 'testNickname',
        socketID: 'testSocketID',
        points: 5.0,
        playerType: 'X',
      );

      expect(player.nickname, 'testNickname');
      expect(player.socketID, 'testSocketID');
      expect(player.points, 5.0);
      expect(player.playerType, 'X');
    });

    test('Creating PlayerTicTacToe from map', () {
      final playerMap = {
        'nickname': 'testNickname',
        'socketID': 'testSocketID',
        'points': 5,
        'playerType': 'X',
      };

      final player = PlayerTicTacToe.fromMap(playerMap);

      expect(player.nickname, 'testNickname');
      expect(player.socketID, 'testSocketID');
      expect(player.points, 5.0); // points should be double
      expect(player.playerType, 'X');
    });

    test('Copying PlayerTicTacToe', () {
      final player = PlayerTicTacToe(
        nickname: 'testNickname',
        socketID: 'testSocketID',
        points: 5.0,
        playerType: 'X',
      );

      final copiedPlayer = player.copyWith(nickname: 'newNickname');

      expect(copiedPlayer.nickname, 'newNickname');
      expect(copiedPlayer.socketID, 'testSocketID');
      expect(copiedPlayer.points, 5.0);
      expect(copiedPlayer.playerType, 'X');
    });
  });
}
