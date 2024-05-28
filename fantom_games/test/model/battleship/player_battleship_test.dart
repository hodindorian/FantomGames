import 'package:fantom_games/model/battleship/boats.dart';
import 'package:fantom_games/model/battleship/player_battleship.dart';
import 'package:test/test.dart';


void main() {
  group('PlayerBattleShip tests', () {
    test('Creating PlayerBattleShip with initialize constructor', () {
      final boats = Boats();
      final player = PlayerBattleShip.initialize(
        nickname: 'testNickname',
        socketID: 'testSocketID',
        nbPlayer: 1,
        boats: boats
      );

      expect(player.nickname, 'testNickname');
      expect(player.socketID, 'testSocketID');
      expect(player.nbPlayer, 1);
      expect(player.boats, boats);
    });

    test('Creating PlayerBattleShip with regular constructor', () {
      final player = PlayerBattleShip(
        nickname: 'testNickname',
        socketID: 'testSocketID',
        nbPlayer: 1,
        boats: Boats()
      );

      expect(player.nickname, 'testNickname');
      expect(player.socketID, 'testSocketID');
      expect(player.nbPlayer, 1);
      expect(player.boats, isNotNull);
    });

    test('Copying PlayerBattleShip', () {
      final player = PlayerBattleShip(
        nickname: 'testNickname',
        socketID: 'testSocketID',
        nbPlayer: 1,
        boats: Boats()
      );

      final copiedPlayer = player.copyWith(nickname: 'newNickname');

      expect(copiedPlayer.nickname, 'newNickname');
      expect(copiedPlayer.socketID, 'testSocketID');
      expect(copiedPlayer.nbPlayer, 1);
    });
  });
}
