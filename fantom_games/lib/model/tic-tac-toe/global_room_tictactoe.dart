import 'package:fantom_games/model/tic-tac-toe/player_tic_tac_toe.dart';
import 'package:flutter/material.dart';

class RoomGlobalTicTacToe extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  List<String> _displayElement = ['', '', '', '', '', '', '', '', ''];
  int _filledBoxes = 0;
  bool endRound = false;
  bool endGame = false;
  int nbRound = 1;
  String winner = '';
  late PlayerTicTacToe actualPlayer;
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
    _filledBoxes = 0;
    for (var item in _displayElement){
      if (item!=''){
        _filledBoxes+=1;
      }
    }
    notifyListeners();
  }

  void setFilledBoxesTo0() {
    _displayElement =  ['', '', '', '', '', '', '', '', ''];
    _filledBoxes = 0;
  }

  void reset() {
    setFilledBoxesTo0();
    endRound = false;
    endGame = false;
    nbRound = 1;
    winner = '';
    _player1 = PlayerTicTacToe(
      nickname: '',
      socketID: '',
      points: 0,
      playerType: 'X',
    );
    _player2 = PlayerTicTacToe(
      nickname: '',
      socketID: '',
      points: 0,
      playerType: 'O',
    );
    notifyListeners();
  }

}
