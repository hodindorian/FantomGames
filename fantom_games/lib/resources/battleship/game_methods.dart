import 'package:fantom_games/model/battleship/global_room_battleship.dart';
import 'package:fantom_games/model/battleship/player_battleship.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:fantom_games/reusable_widget/method/messsage_pop_up.dart';

class GameMethodsBattleship {
  void checkWinner(BuildContext context, Socket socketClient) {
    RoomGlobalBattleShip roomGlobal = Provider.of<RoomGlobalBattleShip>(context, listen: false);
    String winner = '';
    if(roomGlobal.endGame==false){
      if(roomGlobal.player1.actualBoats.isEmpty) {
        winner = roomGlobal.player2.nickname;
      }else {
        winner = roomGlobal.player1.nickname;
      }
      if (roomGlobal.actualPlayer.nickname == winner) {
        socketClient.emit('winner', {
          'winnerSocketId': roomGlobal.actualPlayer.socketID,
          'roomId':roomGlobal.roomData['id'],
        });
        if(roomGlobal.endGame==false){
          roomGlobal.endGame = true;
          showMessagePopUp(
              context, "Résultat :",
              '${roomGlobal.actualPlayer.nickname} a gagné la partie!',
              "FFFFFF"
          );
        }
      } else {
        PlayerBattleShip winner;
        if(roomGlobal.actualPlayer.nickname == roomGlobal.player1.nickname){
          winner = roomGlobal.player2;
        }else{
          winner = roomGlobal.player1;
        }
        if(roomGlobal.endGame==false){
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

  void clearGame(BuildContext context, Socket socketClient) {
    RoomGlobalBattleShip roomGlobal = Provider.of<RoomGlobalBattleShip>(context, listen: false);
    for (int i = 0; i < roomGlobal.displayElements.length; i++) {
      roomGlobal.updateDisplayElements(i, '');
    }
    socketClient.close();
  }
}
