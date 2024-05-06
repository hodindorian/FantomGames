class PlayerBattleShip {
  final String nickname;
  final String socketID;
  final double points;
  late final List<dynamic> boats;
  late final List<dynamic> actualBoats;

  PlayerBattleShip({
    required this.nickname,
    required this.socketID,
    required this.points,
    required this.boats,
    required this.actualBoats
  });

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'socketID': socketID,
      'points': points,
      'boat': boats,
      'actualBoats': actualBoats
    };
  }

  set points(double newPoints) {
    points = newPoints;
  }

  factory PlayerBattleShip.fromMap(Map<String, dynamic> map) {
    return PlayerBattleShip(
      nickname: map['nickname'] ?? '',
      socketID: map['socketID'] ?? '',
      points: map['points']?.toInt() ?? 0.0,
      boats: [],
      actualBoats: []
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
      points: points ?? this.points,
      boats: [],
      actualBoats: []
    );
  }

  void setBoatsStart(List<dynamic> newBoats){
    boats.add(newBoats);
    actualBoats.add(newBoats);
  }

  void updateBoats(List<dynamic> updatedBoats){
    actualBoats.add(updatedBoats);
  }
}
