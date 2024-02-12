import 'package:fantom_games/model/battleship/global_room_battleship.dart';
import 'package:fantom_games/resources/battleship/socket_client.dart';
import 'package:fantom_games/views/home/main_page.dart';
import 'package:fantom_games/views/tic-tac-toe/game_view.dart';
import 'package:fantom_games/views/tic-tac-toe/lobby.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:fantom_games/reusable_widget/method/message_bar.dart';
import 'game_methods.dart';

class SocketMethodsBattleShip {
  final _socketClient = SocketClientBattleShip.instance.socket!;

  Socket get socketClient => _socketClient;

  // EMITS
  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
      });
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

  // LISTENERS
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (room) {
      Provider.of<RoomGlobalBattleShip>(context, listen: false).updateRoomData(room);
      Navigator.push(context,
          MaterialPageRoute(builder: (
              context) => Lobby(roomID: room['id'])
          )
      );
      _socketClient.on('joinRoomSuccess', (room) {
        Navigator.push(context,
            MaterialPageRoute(builder: (
                context) => const GameView()
            )
        );
      });
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomGlobalBattleShip>(context, listen: false)
          .updateRoomData(room);
      Navigator.push(context,
          MaterialPageRoute(builder: (
              context) => const GameView()
          ),
      );
    });
  }

  void errorOccuredListener(BuildContext context) {
    _socketClient.on('errorOccurred', (data) {
      showMessageBar(context, data);
    });
  }

  void updatePlayersStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      Provider.of<RoomGlobalBattleShip>(context, listen: false).updatePlayer1(playerData[0]);
      Provider.of<RoomGlobalBattleShip>(context, listen: false).updatePlayer2(playerData[1]);
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomGlobalBattleShip>(context, listen: false)
          .updateRoomData(data);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomGlobalBattleShip roomGlobal = Provider.of<RoomGlobalBattleShip>(context, listen: false);
      roomGlobal.updateDisplayElements(
        data['index'],
        data['choice'],
      );
      roomGlobal.updateRoomData(data['room']);
      //GameMethods().checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on('pointIncrease', (playerData) {
      var roomGlobal = Provider.of<RoomGlobalBattleShip>(context, listen: false);
      if (playerData['socketID'] == roomGlobal.player1.socketID) {
        roomGlobal.updatePlayer1(playerData);
      }else if(playerData['socketID'] == roomGlobal.player2.socketID){
        roomGlobal.updatePlayer2(playerData);
      }
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient.on('endgame', (playerData) {
      var roomGlobal = Provider.of<RoomGlobalBattleShip>(context, listen: false);
      if (playerData['socketID'] == roomGlobal.player1.socketID) {
        roomGlobal.updatePlayer1(playerData);
      }else if(playerData['socketID'] == roomGlobal.player2.socketID){
        roomGlobal.updatePlayer2(playerData);
      }
    });
  }

  void nextRound(BuildContext context){
    var roomGlobal = Provider.of<RoomGlobalBattleShip>(context, listen: false);
    _socketClient.emit('nextRound', {
      'roomId': roomGlobal.roomData['id'],
    });
    _socketClient.on('nextRound',(room) {
    GameMethodsBattleShip().clearBoard(context, socketClient);
    });
  }

  void endGame(BuildContext context){
    GameMethodsBattleShip().clearGame(context, socketClient);
    Navigator.push(context,
      MaterialPageRoute(builder: (
          context) => const MainPage(title: "Fin du jeu")
      ),
    );
  }


  void getBoatsListener(BuildContext context) {
    _socketClient.on('getBoats', (boats) {
      var roomGlobal = Provider.of<RoomGlobalBattleShip>(context, listen: false);
      if (boats['playerID'] == roomGlobal.player1.socketID) {
        roomGlobal.updatePlayer1Boats(boats['boats']);
      }else if(boats['playerID'] == roomGlobal.player2.socketID){
        roomGlobal.updatePlayer2Boats(boats['boats']);
      }
    });
  }

  void getBoats(BuildContext context){
    var roomGlobal = Provider.of<RoomGlobalBattleShip>(context, listen: false);
    _socketClient.emit('getBoats', {
      'playerID': roomGlobal.player1.socketID,
      'roomId': roomGlobal.roomData['id'],
    });
  }
}
