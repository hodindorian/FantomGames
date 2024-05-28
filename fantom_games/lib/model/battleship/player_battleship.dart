import 'boats.dart';

class PlayerBattleShip {
  final String nickname;
  final String socketID;
  final int nbPlayer;
  late final Boats boats;

  PlayerBattleShip.initialize({
    required this.nickname,
    required this.socketID,
    required this.nbPlayer,
    required this.boats,
  });

  PlayerBattleShip({
    required this.nickname,
    required this.socketID,
    required this.nbPlayer,
    required this.boats
  });
  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'socketID': socketID,
      'nbPlayer': nbPlayer,
      'boats': null,
    };
  }

  set nbPlayer(int newNbPlayer) {
    nbPlayer = newNbPlayer;
  }

  factory PlayerBattleShip.fromMap1(Map<String, dynamic> map) {
    PlayerBattleShip player1 = PlayerBattleShip(
        nickname: map['nickname'] ?? '',
        socketID: map['socketID'] ?? '',
        nbPlayer: 1,
        boats: Boats()
    );
    player1.boats.createBoats(map['boats'][0]);
    return player1;
  }

  factory PlayerBattleShip.fromMap2(Map<String, dynamic> map) {
    PlayerBattleShip player2 = PlayerBattleShip(
        nickname: map['nickname'] ?? '',
        socketID: map['socketID'] ?? '',
        nbPlayer: 2,
        boats: Boats()
    );
    player2.boats.createBoats(map['boats'][0]);
    return player2;
  }

  PlayerBattleShip copyWith({
    String? nickname,
    String? socketID,
    int? nbPlayer,
    Boats? boats
  }) {
    return PlayerBattleShip(
        nickname: nickname ?? this.nickname,
        socketID: socketID ?? this.socketID,
        nbPlayer: nbPlayer ?? this.nbPlayer,
        boats: boats ?? this.boats
    );
  }

  void setBoatsStart(Boats newBoats){
    boats.setBoats(newBoats);
  }
}
