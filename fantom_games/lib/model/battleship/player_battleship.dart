import 'boats.dart';

class PlayerBattleShip {
  final String nickname;
  final String socketID;
  final int nbPlayer;
  late final Boats boats;
  late final Boats actualBoats;

  PlayerBattleShip.initialize({
    required this.nickname,
    required this.socketID,
    required this.nbPlayer,
    required this.boats,
    required this.actualBoats,
  });

  PlayerBattleShip({
    required this.nickname,
    required this.socketID,
    required this.nbPlayer,
  }) : boats = Boats(),
        actualBoats = Boats();
  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'socketID': socketID,
      'nbPlayer': nbPlayer,
      'boats': null,
      'actualBoats': null
    };
  }

  set nbPlayer(int newNbPlayer) {
    nbPlayer = newNbPlayer;
  }

  factory PlayerBattleShip.fromMap1(Map<String, dynamic> map) {
    return PlayerBattleShip(
        nickname: map['nickname'] ?? '',
        socketID: map['socketID'] ?? '',
        nbPlayer: 1
    );
  }

  factory PlayerBattleShip.fromMap2(Map<String, dynamic> map) {
    return PlayerBattleShip(
        nickname: map['nickname'] ?? '',
        socketID: map['socketID'] ?? '',
        nbPlayer: 2
    );
  }

  PlayerBattleShip copyWith({
    String? nickname,
    String? socketID,
    int? nbPlayer,
    String? playerType
  }) {
    return PlayerBattleShip(
        nickname: nickname ?? this.nickname,
        socketID: socketID ?? this.socketID,
        nbPlayer: nbPlayer ?? this.nbPlayer
    );
  }

  void setBoatsStart(Boats newBoats){
    boats.setBoats(newBoats);
    actualBoats.setBoats(newBoats);
  }

  void updateBoats(Boats updatedBoats){
    actualBoats=updatedBoats;
  }
}
