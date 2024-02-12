import 'package:fantom_games/model/battleship/global_room_battleship.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class GameMethodsBattleShip {

  void clearBoard(BuildContext context, Socket socketClient) {
    RoomGlobalBattleShip roomGlobal = Provider.of<RoomGlobalBattleShip>(context, listen: false);
    for (int i = 0; i < roomGlobal.displayElements.length; i++) {
      roomGlobal.updateDisplayElements(i, '');
    }
    socketClient.emit('clearBoard', {
      'roomId': roomGlobal.roomData['id']
    });
    roomGlobal.endRound = false;
    roomGlobal.setFilledBoxesTo0();
  }

  void clearGame(BuildContext context, Socket socketClient) {
    RoomGlobalBattleShip roomGlobal = Provider.of<RoomGlobalBattleShip>(context, listen: false);
    for (int i = 0; i < roomGlobal.displayElements.length; i++) {
      roomGlobal.updateDisplayElements(i, '');
    }
    socketClient.emit('clearGame', {
      'roomId': roomGlobal.roomData['id']
    });
    roomGlobal.endGame = false;
    roomGlobal.setFilledBoxesTo0();
  }
}
