import 'boats.dart';

class PlayerBattleShip {
  final String nickname;
  final String socketID;
  final double points;
  late final Boats boats;
  late final Boats actualBoats;

  PlayerBattleShip.initialize({
    required this.nickname,
    required this.socketID,
    required this.points,
    required this.boats,
    required this.actualBoats,
  });

  PlayerBattleShip({
    required this.nickname,
    required this.socketID,
    required this.points,
  }) : boats = Boats(),
        actualBoats = Boats();
  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'socketID': socketID,
      'points': points,
      'boats': null,
      'actualBoats': null
    };
  }

  set points(double newPoints) {
    points = newPoints;
  }

  factory PlayerBattleShip.fromMap(Map<String, dynamic> map) {
    return PlayerBattleShip(
        nickname: map['nickname'] ?? '',
        socketID: map['socketID'] ?? '',
        points: map['points']?.toInt() ?? 0.0
    );
  }

  PlayerBattleShip copyWith({
    String? nickname,
    String? socketID,
    double? points,
    String? playerType
  }) {
    return PlayerBattleShip(
        nickname: nickname ?? this.nickname,
        socketID: socketID ?? this.socketID,
        points: points ?? this.points
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
