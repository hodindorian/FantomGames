import 'package:fantom_games/model/tic-tac-toe/global_room_tictactoe.dart';
import 'package:fantom_games/resources/tic-tac-toe/socket_client.dart';
import 'package:fantom_games/views/home/main_page.dart';
import 'package:fantom_games/views/tic-tac-toe/game_view.dart';
import 'package:fantom_games/views/tic-tac-toe/lobby.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:fantom_games/reusable_widget/method/message_bar.dart';
import 'package:fantom_games/reusable_widget/method/message_pop_up.dart';
import 'package:fantom_games/resources/tic-tac-toe/game_methods.dart';

class SocketMethodsTicTacToe {
  final _socketClient = SocketClientTicTacToe.instance.socket!;

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
      Provider.of<RoomGlobalTicTacToe>(context, listen: false).updateRoomData(room);
      Navigator.push(context,
          MaterialPageRoute(builder: (
              context) => LobbyTicTacToe(roomID: room['id'])
          )
      );
      _socketClient.on('joinRoomSuccess', (room) {
        Navigator.push(context,
            MaterialPageRoute(builder: (
                context) => const GameViewTicTacToe()
            )
        );
      });
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomGlobalTicTacToe>(context, listen: false)
          .updateRoomData(room);
      Navigator.push(context,
          MaterialPageRoute(builder: (
              context) => const GameViewTicTacToe()
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
      Provider.of<RoomGlobalTicTacToe>(context, listen: false).updatePlayer1(playerData[0]);
      Provider.of<RoomGlobalTicTacToe>(context, listen: false).updatePlayer2(playerData[1]);
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomGlobalTicTacToe>(context, listen: false)
          .updateRoomData(data);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomGlobalTicTacToe roomGlobal = Provider.of<RoomGlobalTicTacToe>(context, listen: false);
      roomGlobal.updateDisplayElements(
        data['index'],
        data['choice'],
      );
      roomGlobal.updateRoomData(data['room']);
      GameMethodsTicTacToe().checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on('pointIncrease', (playerData) {
      var roomGlobal = Provider.of<RoomGlobalTicTacToe>(context, listen: false);
      if (playerData['socketID'] == roomGlobal.player1.socketID) {
        playerData['points'] == playerData['points']/2;
        roomGlobal.updatePlayer1(playerData);
      }else if(playerData['socketID'] == roomGlobal.player2.socketID){
        roomGlobal.updatePlayer2(playerData);
      }
    });

  }

  void clearBoardListener(BuildContext context) {
    _socketClient.on('clearBoard', (nothing) {
      GameMethodsTicTacToe().clearBoard(context, socketClient, true);
    });
  }

  void nextRound(BuildContext context){
    var roomGlobal = Provider.of<RoomGlobalTicTacToe>(context, listen: false);
    _socketClient.emit('nextRound', {
      'roomId': roomGlobal.roomData['id'],
    });
    _socketClient.on('nextRound',(room) {
      GameMethodsTicTacToe().clearBoard(context, socketClient, false);
    });
  }

  void endGame(BuildContext context){
    var roomGlobal = Provider.of<RoomGlobalTicTacToe>(context, listen: false);
    _socketClient.emit('endGame', {
      'roomId': roomGlobal.roomData['id'],
    });
    GameMethodsTicTacToe().clearGame(context, socketClient);
    Navigator.push(context,
      MaterialPageRoute(builder: (
          context) => const MainPage(title: "Fin du jeu")
      ),
    );
  }

  void endGameListener(BuildContext context) {
    var roomGlobal = Provider.of<RoomGlobalTicTacToe>(context, listen: false);
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
    var roomGlobal = Provider.of<RoomGlobalTicTacToe>(context, listen: false);
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
}
