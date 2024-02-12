import 'package:fantom_games/model/battleship/player_battleship.dart';
import 'package:flutter/material.dart';

class RoomGlobalBattleShip extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  final List<String> _displayElement = ['', '', '', '', '', '', '', '', ''];
  int _filledBoxes = 0;
  bool endRound = false;
  bool endGame = false;
  String winner = '';
  bool animation = false;
  String actualPlayer = '';
  PlayerBattleShip _player1 = PlayerBattleShip(
    nickname: '',
    socketID: '',
    points: 0,
    boats: [],
  );

  PlayerBattleShip _player2 = PlayerBattleShip(
    nickname: '',
    socketID: '',
    points: 0,
    boats: [],
  );

  Map<String, dynamic> get roomData => _roomData;
  List<String> get displayElements => _displayElement;
  int get filledBoxes => _filledBoxes;
  PlayerBattleShip get player1 => _player1;
  PlayerBattleShip get player2 => _player2;

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = PlayerBattleShip.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = PlayerBattleShip.fromMap(player2Data);
    notifyListeners();
  }

  void updateDisplayElements(int index, String choice) {
    _displayElement[index] = choice;
    _filledBoxes += 1;
    notifyListeners();
  }

  void setFilledBoxesTo0() {
    _filledBoxes = 0;
  }

  void updatePlayer1Boats(List<String> boats) {
    _player1.boats = boats;
  }

  void updatePlayer2Boats(List<String> boats) {
    _player2.boats = boats;
  }
}
