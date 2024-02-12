class PlayerBattleShip {
  final String nickname;
  final String socketID;
  final double points;
  late final List<String> boats;

  PlayerBattleShip({
    required this.nickname,
    required this.socketID,
    required this.points,
    required this.boats
  });

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'socketID': socketID,
      'points': points,
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
      boats: map['boat'] ??  []
    );
  }

  PlayerBattleShip copyWith({
    String? nickname,
    String? socketID,
    double? points,
    String? playerType,
    List<String>? boats,
  }) {
    return PlayerBattleShip(
      nickname: nickname ?? this.nickname,
      socketID: socketID ?? this.socketID,
      points: points ?? this.points,
      boats: boats ?? this.boats
    );
  }
}
