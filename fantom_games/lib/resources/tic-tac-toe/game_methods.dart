import 'package:fantom_games/model/tic-tac-toe/global_room.dart';
import 'package:fantom_games/reusable_widget/method/messsage_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class GameMethods {
  void checkWinner(BuildContext context, Socket socketClient) {
    RoomGlobal roomGlobal = Provider.of<RoomGlobal>(context, listen: false);
    String winner = '';

    if(roomGlobal.endRound==false || roomGlobal.endGame==false){
      // Lignes
      if (roomGlobal.displayElements[0] == roomGlobal.displayElements[1] &&
          roomGlobal.displayElements[0] == roomGlobal.displayElements[2] &&
          roomGlobal.displayElements[0] != '') {
        winner = roomGlobal.displayElements[0];
      }else if (roomGlobal.displayElements[3] == roomGlobal.displayElements[4] &&
          roomGlobal.displayElements[3] == roomGlobal.displayElements[5] &&
          roomGlobal.displayElements[3] != '') {
        winner = roomGlobal.displayElements[3];
      }else if (roomGlobal.displayElements[6] == roomGlobal.displayElements[7] &&
          roomGlobal.displayElements[6] == roomGlobal.displayElements[8] &&
          roomGlobal.displayElements[6] != '') {
        winner = roomGlobal.displayElements[6];
      }else

        // Colones
      if (roomGlobal.displayElements[0] == roomGlobal.displayElements[3] &&
          roomGlobal.displayElements[0] == roomGlobal.displayElements[6] &&
          roomGlobal.displayElements[0] != '') {
        winner = roomGlobal.displayElements[0];
      }else if (roomGlobal.displayElements[1] == roomGlobal.displayElements[4] &&
          roomGlobal.displayElements[1] == roomGlobal.displayElements[7] &&
          roomGlobal.displayElements[1] != '') {
        winner = roomGlobal.displayElements[1];
      }else if (roomGlobal.displayElements[2] == roomGlobal.displayElements[5] &&
          roomGlobal.displayElements[2] == roomGlobal.displayElements[8] &&
          roomGlobal.displayElements[2] != '') {
        winner = roomGlobal.displayElements[2];
      }else

        // Diagonales
      if (roomGlobal.displayElements[0] == roomGlobal.displayElements[4] &&
          roomGlobal.displayElements[0] == roomGlobal.displayElements[8] &&
          roomGlobal.displayElements[0] != '') {
        winner = roomGlobal.displayElements[0];
      }else if (roomGlobal.displayElements[2] == roomGlobal.displayElements[4] &&
          roomGlobal.displayElements[2] == roomGlobal.displayElements[6] &&
          roomGlobal.displayElements[2] != '') {
        winner =roomGlobal.displayElements[2];
      } else if (roomGlobal.filledBoxes == 18) {
        winner = '';
        roomGlobal.endRound = true;
        showMessagePopUp(
            context, "Résultat :",
            "Égalité ! C'était serré !",
            "FFFFFF"
        );
      }

      if (winner != '') {
        if (roomGlobal.player1.playerType == winner) {
          socketClient.emit('winner', {
            'winnerSocketId': roomGlobal.player1.socketID,
            'roomId':roomGlobal.roomData['id'],
          });
          if(roomGlobal.player1.points <= 3 && roomGlobal.player2.points <= 3 && roomGlobal.endRound==false){
            roomGlobal.endRound = true;
            showMessagePopUp(
                context, "Résultat :",
                '${roomGlobal.player1.nickname} a gagné !',
                "FFFFFF"
            );
          }else if(roomGlobal.endRound==false && roomGlobal.endGame==false){
            roomGlobal.endGame = true;
            showMessagePopUp(
                context, "Résultat :",
                '${roomGlobal.player1.nickname} a gagné la partie!',
                "FFFFFF"
            );
          }
        } else if(roomGlobal.player2.playerType == winner) {
          socketClient.emit('winner', {
            'winnerSocketId': roomGlobal.player2.socketID,
            'roomId':roomGlobal.roomData['id'],
          });
          if(roomGlobal.player1.points <= 3 && roomGlobal.player2.points <= 3 && roomGlobal.endRound==false){
            roomGlobal.endRound = true;
            showMessagePopUp(
                context, "Résultat :",
                '${roomGlobal.player2.nickname} a gagné !',
                "FFFFFF"
            );
          }else if(roomGlobal.endRound==false && roomGlobal.endGame==false){
            roomGlobal.endGame = true;
            showMessagePopUp(
                context, "Résultat :",
                '${roomGlobal.player2.nickname} a gagné la partie!',
                "FFFFFF"
            );
          }
        }
      }
    }
  }

  void clearBoard(BuildContext context, Socket socketClient) {
    RoomGlobal roomGlobal = Provider.of<RoomGlobal>(context, listen: false);
    for (int i = 0; i < roomGlobal.displayElements.length; i++) {
      roomGlobal.updateDisplayElements(i, '');
    }
    socketClient.emit('clearBoard', {
      'roomId': roomGlobal.roomData['id']
    });
    roomGlobal.endRound = false;
    roomGlobal.setFilledBoxesTo0();
    roomGlobal.nbRound = roomGlobal.nbRound+1;
  }

  void clearGame(BuildContext context, Socket socketClient) {
    RoomGlobal roomGlobal = Provider.of<RoomGlobal>(context, listen: false);
    for (int i = 0; i < roomGlobal.displayElements.length; i++) {
      roomGlobal.updateDisplayElements(i, '');
    }
    socketClient.emit('clearGame', {
      'roomId': roomGlobal.roomData['id']
    });
    roomGlobal.endGame = false;
    roomGlobal.setFilledBoxesTo0();
    roomGlobal.nbRound = 1;
  }
}
