import 'package:fantom_games/model/tic-tac-toe/global_room.dart';
import 'package:fantom_games/resources/tic-tac-toe/socket_client.dart';
import 'package:fantom_games/views/home/main_page.dart';
import 'package:fantom_games/views/tic-tac-toe/game_view.dart';
import 'package:fantom_games/views/tic-tac-toe/lobby.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:fantom_games/reusable_widget/method/message_bar.dart';
import 'package:fantom_games/reusable_widget/method/messsage_pop_up.dart';
import 'game_methods.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

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
      Provider.of<RoomGlobal>(context, listen: false).updateRoomData(room);
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
      //Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomGlobal>(context, listen: false)
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
      Provider.of<RoomGlobal>(context, listen: false).updatePlayer1(playerData[0]);
      Provider.of<RoomGlobal>(context, listen: false).updatePlayer2(playerData[1]);
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomGlobal>(context, listen: false)
          .updateRoomData(data);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomGlobal roomGlobal = Provider.of<RoomGlobal>(context, listen: false);
      roomGlobal.updateDisplayElements(
        data['index'],
        data['choice'],
      );
      roomGlobal.updateRoomData(data['room']);
      GameMethods().checkWinner(context, _socketClient, roomGlobal.nbRound);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on('pointIncrease', (playerData) {
      print(playerData.toString());

      var roomGlobal = Provider.of<RoomGlobal>(context, listen: false);
      if (playerData['socketID'] == roomGlobal.player1.socketID) {
        roomGlobal.updatePlayer1(playerData);
      }else if(playerData['socketID'] == roomGlobal.player2.socketID){
        roomGlobal.updatePlayer2(playerData);
      }
      roomGlobal.nbRound = roomGlobal.nbRound+1;
    });
  }

  void nextRound(BuildContext context){
    var roomGlobal = Provider.of<RoomGlobal>(context, listen: false);
    _socketClient.emit('nextRound', {
      'roomId': roomGlobal.roomData['id'],
    });

    _socketClient.on('nextRound',(room) {
    GameMethods().clearBoard(context, socketClient);
    });
  }

  void endGame(BuildContext context){
    GameMethods().clearGame(context, socketClient);
    Navigator.push(context,
      MaterialPageRoute(builder: (
          context) => const MainPage(title: "Fin du jeu")
      ),
    );
  }

  void endGameListener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      showMessagePopUp(
          context, "Résultat :",
          '${playerData['nickname']} a gagné la partie!',
          "FFFFFF"
      );
    });
  }
}
