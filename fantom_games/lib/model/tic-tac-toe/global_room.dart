import 'package:fantom_games/model/tic-tac-toe/player_tic_tac_toe.dart';
import 'package:flutter/material.dart';

class RoomGlobal extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  final List<String> _displayElement = ['', '', '', '', '', '', '', '', ''];
  int _filledBoxes = 0;
  bool endRound = false;
  bool endGame = false;
  int nbRound = 1;
  String winner = '';
  bool animation = false;
  String actuelPlayer = '';
  PlayerTicTacToe _player1 = PlayerTicTacToe(
    nickname: '',
    socketID: '',
    points: 0,
    playerType: 'X',
  );

  PlayerTicTacToe _player2 = PlayerTicTacToe(
    nickname: '',
    socketID: '',
    points: 0,
    playerType: 'O',
  );

  Map<String, dynamic> get roomData => _roomData;
  List<String> get displayElements => _displayElement;
  int get filledBoxes => _filledBoxes;
  PlayerTicTacToe get player1 => _player1;
  PlayerTicTacToe get player2 => _player2;

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = PlayerTicTacToe.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = PlayerTicTacToe.fromMap(player2Data);
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
}