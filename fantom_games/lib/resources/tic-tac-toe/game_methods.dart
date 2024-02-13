import 'package:fantom_games/model/tic-tac-toe/global_room_tictactoe.dart';
import 'package:fantom_games/model/tic-tac-toe/player_tic_tac_toe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:fantom_games/reusable_widget/method/messsage_pop_up.dart';

class GameMethods {
  void checkWinner(BuildContext context, Socket socketClient) {
    RoomGlobalTicTacToe roomGlobal = Provider.of<RoomGlobalTicTacToe>(context, listen: false);
    String winner = '';
    if(roomGlobal.endRound==false || roomGlobal.endGame==false){
      // Lignes
      if (roomGlobal.displayElements[0] == roomGlobal.displayElements[1] &&
          roomGlobal.displayElements[0] == roomGlobal.displayElements[2] &&
          roomGlobal.displayElements[0] != '') {

        winner = roomGlobal.displayElements[0];
        roomGlobal.winner = roomGlobal.displayElements[0];

      }else if (roomGlobal.displayElements[3] == roomGlobal.displayElements[4] &&
          roomGlobal.displayElements[3] == roomGlobal.displayElements[5] &&
          roomGlobal.displayElements[3] != '') {

        winner = roomGlobal.displayElements[3];
        roomGlobal.winner = roomGlobal.displayElements[3];

      }else if (roomGlobal.displayElements[6] == roomGlobal.displayElements[7] &&
          roomGlobal.displayElements[6] == roomGlobal.displayElements[8] &&
          roomGlobal.displayElements[6] != '') {

        winner = roomGlobal.displayElements[6];
        roomGlobal.winner = roomGlobal.displayElements[6];

      }else

        // Colones
      if (roomGlobal.displayElements[0] == roomGlobal.displayElements[3] &&
          roomGlobal.displayElements[0] == roomGlobal.displayElements[6] &&
          roomGlobal.displayElements[0] != '') {

        winner = roomGlobal.displayElements[0];
        roomGlobal.winner = roomGlobal.displayElements[0];

      }else if (roomGlobal.displayElements[1] == roomGlobal.displayElements[4] &&
          roomGlobal.displayElements[1] == roomGlobal.displayElements[7] &&
          roomGlobal.displayElements[1] != '') {

        winner = roomGlobal.displayElements[1];
        roomGlobal.winner = roomGlobal.displayElements[1];

      }else if (roomGlobal.displayElements[2] == roomGlobal.displayElements[5] &&
          roomGlobal.displayElements[2] == roomGlobal.displayElements[8] &&
          roomGlobal.displayElements[2] != '') {

        winner = roomGlobal.displayElements[2];
        roomGlobal.winner = roomGlobal.displayElements[2];

      }else

        // Diagonales
      if (roomGlobal.displayElements[0] == roomGlobal.displayElements[4] &&
          roomGlobal.displayElements[0] == roomGlobal.displayElements[8] &&
          roomGlobal.displayElements[0] != '') {

        winner = roomGlobal.displayElements[0];
        roomGlobal.winner = roomGlobal.displayElements[0];

      }else if (roomGlobal.displayElements[2] == roomGlobal.displayElements[4] &&
          roomGlobal.displayElements[2] == roomGlobal.displayElements[6] &&
          roomGlobal.displayElements[2] != '') {

        winner = roomGlobal.displayElements[2];
        roomGlobal.winner = roomGlobal.displayElements[2];

      } else if ((roomGlobal.filledBoxes == 18 && roomGlobal.actualPlayer.playerType == 'X') || (roomGlobal.filledBoxes == 9 && roomGlobal.actualPlayer.playerType == 'O')) {
        winner = '';
        roomGlobal.animation = true;
        roomGlobal.endRound = true;
        showMessagePopUp(
            context, "Résultat :",
            "Égalité ! C'était serré !",
            "FFFFFF"
        );
        roomGlobal.setFilledBoxesTo0();
      }

      if (winner != '') {
        roomGlobal.animation = true;
        print("actual => "+roomGlobal.actualPlayer.playerType);
        print("winner => "+winner);
        print("winner room => "+roomGlobal.winner);
        if (roomGlobal.actualPlayer.playerType == winner) {
          socketClient.emit('winner', {
            'winnerSocketId': roomGlobal.actualPlayer.socketID,
            'roomId':roomGlobal.roomData['id'],
          });
          if(roomGlobal.actualPlayer.points < 3 && roomGlobal.endRound==false){
            showMessagePopUp(
                context, "Résultat :",
                '${roomGlobal.actualPlayer.nickname} a gagné !',
                "FFFFFF"
            );
            roomGlobal.endRound = true;
          }else if(roomGlobal.endRound==false && roomGlobal.endGame==false){
            roomGlobal.endGame = true;
            showMessagePopUp(
                context, "Résultat :",
                '${roomGlobal.player1.nickname} a gagné la partie!',
                "FFFFFF"
            );
          }
        } else {
          PlayerTicTacToe winner;
          if(roomGlobal.actualPlayer.nickname == roomGlobal.player1.nickname){
            winner = roomGlobal.player2;
          }else{
            winner = roomGlobal.player1;
          }
          if(winner.points < 3 && roomGlobal.endRound==false){
            showMessagePopUp(
                context, "Résultat :",
                '${winner.nickname} a gagné !',
                "FFFFFF"
            );
            roomGlobal.endRound = true;
          }else if(roomGlobal.endRound==false && roomGlobal.endGame==false){
            roomGlobal.endGame = true;
            showMessagePopUp(
                context, "Résultat :",
                '${winner.nickname} a gagné la partie!',
                "FFFFFF"
            );
          }
        }
      }
    }
  }

  void clearBoard(BuildContext context, Socket socketClient, bool alreadySendSocket) {
    RoomGlobalTicTacToe roomGlobal = Provider.of<RoomGlobalTicTacToe>(context, listen: false);
    for (int i = 0; i < roomGlobal.displayElements.length; i++) {
      roomGlobal.updateDisplayElements(i, '');
    }
    if(!alreadySendSocket){
      socketClient.emit('clearBoard', {
        'roomId': roomGlobal.roomData['id']
      });
    }
    roomGlobal.endRound = false;
    roomGlobal.setFilledBoxesTo0();
    roomGlobal.nbRound = roomGlobal.nbRound+1;
  }

  void clearGame(BuildContext context, Socket socketClient) {
    RoomGlobalTicTacToe roomGlobal = Provider.of<RoomGlobalTicTacToe>(context, listen: false);
    for (int i = 0; i < roomGlobal.displayElements.length; i++) {
      roomGlobal.updateDisplayElements(i, '');
    }
    roomGlobal.reset();
  }
}
