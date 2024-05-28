import 'package:fantom_games/model/battleship/global_room_battleship.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:fantom_games/reusable_widget/method/messsage_pop_up.dart';

class GameMethodsBattleship {
  void checkWinner(BuildContext context, Socket socketClient) {
    RoomGlobalBattleShip roomGlobal = Provider.of<RoomGlobalBattleShip>(context, listen: false);
    print('winner?');
    int winner = 0;

    if(roomGlobal.endGame==false || roomGlobal.player1.boats.isGameStarted || roomGlobal.player2.boats.isGameStarted){
      if(roomGlobal.player1.boats.isEmpty()) {
        winner = 2;
      }else if(roomGlobal.player2.boats.isEmpty()) {
        winner = 1;
      }
      print("Winner: $winner");
      if (roomGlobal.actualPlayer.nbPlayer == winner) {
        socketClient.emit('winner', {
          'winnerSocketId': roomGlobal.actualPlayer.socketID,
          'roomId':roomGlobal.roomData['id'],
        });
        if(roomGlobal.endGame==false){
          roomGlobal.endGame = true;
          showMessagePopUp(
              context, "Résultat :",
              '$winner a gagné la partie!',
              "FFFFFF"
          );
        }
      }
    }
  }

  void clearGame(BuildContext context, Socket socketClient) {
    RoomGlobalBattleShip roomGlobal = Provider.of<RoomGlobalBattleShip>(context, listen: false);
    for (int i = 0; i < roomGlobal.displayElementsPlayer1.length; i++) {
      roomGlobal.updateDisplayElements1(i, '');
    }
    for (int i = 0; i < roomGlobal.displayElementsPlayer2.length; i++) {
      roomGlobal.updateDisplayElements2(i, '');
    }
    socketClient.close();
  }
}
