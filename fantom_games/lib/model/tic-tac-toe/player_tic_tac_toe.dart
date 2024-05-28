class PlayerTicTacToe {
  final String nickname;
  final String socketID;
  final double points;
  final String playerType;
  PlayerTicTacToe({
    required this.nickname,
    required this.socketID,
    required this.points,
    required this.playerType,
  });

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'socketID': socketID,
      'points': points,
      'playerType': playerType,
    };
  }

  set points(double newPoints) {
    points = newPoints;
  }

  factory PlayerTicTacToe.fromMap(Map<String, dynamic> map) {
    return PlayerTicTacToe(
      nickname: map['nickname'] ?? '',
      socketID: map['socketID'] ?? '',
      points: map['points']?.toDouble() ?? 0.0,
      playerType: map['playerType'] ?? '',
    );
  }

  PlayerTicTacToe copyWith({
    String? nickname,
    String? socketID,
    double? points,
    String? playerType,
  }) {
    return PlayerTicTacToe(
      nickname: nickname ?? this.nickname,
      socketID: socketID ?? this.socketID,
      points: points ?? this.points,
      playerType: playerType ?? this.playerType,
    );
  }
}
