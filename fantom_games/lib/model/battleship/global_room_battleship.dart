import 'package:fantom_games/model/battleship/player_battleship.dart';
import 'package:flutter/material.dart';
import 'boats.dart';

class RoomGlobalBattleShip extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  final List<String> _displayElementPlayer1 = List<String>.filled(100, '');
  final List<String> _displayElementPlayer2 = List<String>.filled(100, '');
  bool endGame = false;
  String winner = '';
  bool animation = false;
  late PlayerBattleShip actualPlayer;
  PlayerBattleShip _player1 = PlayerBattleShip(
    nickname: '',
    socketID: '',
    nbPlayer: 1
  );

  PlayerBattleShip _player2 = PlayerBattleShip(
    nickname: '',
    socketID: '',
    nbPlayer: 2
  );

  Map<String, dynamic> get roomData => _roomData;
  List<String> get displayElementsPlayer1 => _displayElementPlayer1;
  List<String> get displayElementsPlayer2 => _displayElementPlayer2;
  PlayerBattleShip get player1 => _player1;
  PlayerBattleShip get player2 => _player2;

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = PlayerBattleShip.fromMap1(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = PlayerBattleShip.fromMap2(player2Data);
    notifyListeners();
  }

  void updatePlayer1Boats(Boats boats) {
    _player1.boats = boats;
    _player1.actualBoats = boats;
  }

  void updatePlayer2Boats(Boats boats) {
    _player2.boats = boats;
    _player2.actualBoats = boats;
  }

  void updateDisplayElements1(int index, String hit) {
    _displayElementPlayer2[index] = hit;
    notifyListeners();
  }
  void updateDisplayElements2(int index, String hit) {
    _displayElementPlayer1[index] = hit;
    notifyListeners();
  }

  void reset() {
    endGame = false;
    winner = '';
    animation = false;
    _player1 = PlayerBattleShip(
      nickname: '',
      socketID: '',
      nbPlayer: 1
    );
    _player2 = PlayerBattleShip(
      nickname: '',
      socketID: '',
      nbPlayer: 2
    );
    notifyListeners();
  }

  void hitPlayer1(int index) {

  }

  void hitPlayer2(int index) {

  }


}
