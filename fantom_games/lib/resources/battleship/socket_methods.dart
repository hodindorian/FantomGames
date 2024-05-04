import 'package:fantom_games/model/battleship/global_room_battleship.dart';
import 'package:fantom_games/resources/battleship/game_methods.dart';
import 'package:fantom_games/resources/battleship/socket_client.dart';
import 'package:fantom_games/views/battleship/game_view.dart';
import 'package:fantom_games/views/battleship/lobby.dart';
import 'package:fantom_games/views/home/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:fantom_games/reusable_widget/method/message_bar.dart';
import 'package:fantom_games/reusable_widget/method/messsage_pop_up.dart';

class SocketMethodsBattleShip {
  final _socketClient = SocketClientBattleShip.instance.socket!;

  Socket get socketClient => _socketClient;

  void createRoom(String nickname) {
    _socketClient.open();
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
      });
    }
  }

  void joinRoom(String nickname, String roomId) {
    _socketClient.open();
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
              context) => LobbyBattleShip(roomID: room['id'])
          )
      );
      _socketClient.on('joinRoomSuccess', (room) {
        Navigator.push(context,
            MaterialPageRoute(builder: (
                context) => const GameViewBattleShip()
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
              context) => const GameViewBattleShip()
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
      GameMethodsBattleship().checkWinner(context, _socketClient);
    });
  }

  void endGame(BuildContext context){
    var roomGlobal = Provider.of<RoomGlobalBattleShip>(context, listen: false);
    _socketClient.emit('endGame', {
      'roomId': roomGlobal.roomData['id'],
    });
    GameMethodsBattleship().clearGame(context, socketClient);
    Navigator.push(context,
      MaterialPageRoute(builder: (
          context) => const MainPage(title: "Fin du jeu")
      ),
    );
  }

  void endGameListener(BuildContext context) {
    var roomGlobal = Provider.of<RoomGlobalBattleShip>(context, listen: false);
    roomGlobal.reset();
    _socketClient.on('endGame', (nothing) {
      Navigator.push(context,
        MaterialPageRoute(builder: (
            context) => const MainPage(title: "Fin du jeu")
        ),
      );
      showMessagePopUp(
          context, "Fin de partie",
          'Votre adversaire a quitté la partie !',
          "FFFFFF"
      );
    });
  }


  void leaveGame(BuildContext context){
    var roomGlobal = Provider.of<RoomGlobalBattleShip>(context, listen: false);
    _socketClient.emit('leaveGame', {
      'roomId': roomGlobal.roomData['id'],
    });
  }

  void leaveGameListener(BuildContext context){
    _socketClient.on('leaveGame',(nothing) {
      Navigator.push(context,
        MaterialPageRoute(builder: (
            context) => const MainPage(title: "Fin du jeu")
        ),
      );
      showMessagePopUp(
          context, "Abandon",
          'Votre adversaire a abandonné la partie !',
          "FFFFFF"
      );
    });
  }

  void getBoats(BuildContext context){
    var roomGlobal = Provider.of<RoomGlobalBattleShip>(context, listen: false);
    _socketClient.emit('getBoats', {
      'roomId': roomGlobal.roomData['id'],
      'playerId': roomGlobal.actualPlayer.socketID
    });
  }

  void getBoatsListener(BuildContext context){
    var roomGlobal = Provider.of<RoomGlobalBattleShip>(context, listen: false);
    _socketClient.on('getBoats',(data) {
      print(data['boats']);
      roomGlobal.actualPlayer.boats = data['boats'];
    });
  }
}
