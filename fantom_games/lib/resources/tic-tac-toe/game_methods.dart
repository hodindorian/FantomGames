import 'package:fantom_games/model/tic-tac-toe/global_room.dart';
import 'package:fantom_games/resources/tic-tac-toe/socket_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../reusable_widget/method/hex_string_to_color.dart';

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
        showDialog(
            context: context,
            builder: (BuildContext context)
            {
              return AlertDialog(
                  title: const Text("Résultat :"),
                  content: const Text(
                    "Égalité ! C'était serré !",
                  ),
                  backgroundColor: hexStringToColor("FFFFFF"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        SocketMethods().nextRound(context);
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                          'Recommencer la partie',
                          style: TextStyle(
                              color: Colors.black)),
                    ),
                    TextButton(
                      onPressed: () {
                        SocketMethods().endGame(context);
                      },
                      child: const Text(
                          'Retourner à la page d\'accueil',
                          style: TextStyle(
                              color: Colors.black
                          )
                      ),
                    ),
                  ]
              );
            });
      }

      if (winner != '') {
        if (roomGlobal.player1.playerType == winner) {
          socketClient.emit('winner', {
            'winnerSocketId': roomGlobal.player1.socketID,
            'roomId':roomGlobal.roomData['id'],
          });
          if(roomGlobal.player1.points <= 3 && roomGlobal.player2.points <= 3 && roomGlobal.endRound==false){
            roomGlobal.endRound = true;
            showDialog(
                context: context,
                builder: (BuildContext context)
                {
                  return AlertDialog(
                      title: const Text("Résultat :"),
                      content: Text(
                          '${roomGlobal.player1.nickname} a gagné !'
                      ),
                      backgroundColor: hexStringToColor("FFFFFF"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            SocketMethods().nextRound(context);
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                              'Recommencer la partie',
                              style: TextStyle(
                                  color: Colors.black)),
                        ),
                        TextButton(
                          onPressed: () {
                            SocketMethods().endGame(context);
                          },
                          child: const Text(
                              'Retourner à la page d\'accueil',
                              style: TextStyle(
                                  color: Colors.black
                              )
                          ),
                        ),
                      ]
                  );
                });
          }else if(roomGlobal.endRound==false && roomGlobal.endGame==false){
            roomGlobal.endGame = true;
            showDialog(
                context: context,
                builder: (BuildContext context)
                {
                  return AlertDialog(
                      title: const Text("Résultat :"),
                      content: Text(
                        '${roomGlobal.player1.nickname} a gagné la partie!'
                      ),
                      backgroundColor: hexStringToColor("FFFFFF"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            SocketMethods().endGame(context);
                          },
                          child: const Text(
                              'Retourner à la page d\'accueil',
                              style: TextStyle(
                                  color: Colors.black
                              )
                          ),
                        ),
                      ]
                  );
                });
          }
        } else if(roomGlobal.player2.playerType == winner) {
          socketClient.emit('winner', {
            'winnerSocketId': roomGlobal.player2.socketID,
            'roomId':roomGlobal.roomData['id'],
          });
          if(roomGlobal.player1.points <= 3 && roomGlobal.player2.points <= 3 && roomGlobal.endRound==false){
            roomGlobal.endRound = true;
            showDialog(
                context: context,
                builder: (BuildContext context)
                {
                  return AlertDialog(
                      title: const Text("Résultat :"),
                      content: Text(
                          '${roomGlobal.player2.nickname} a gagné !'
                      ),
                      backgroundColor: hexStringToColor("FFFFFF"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            SocketMethods().nextRound(context);
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                              'Recommencer la partie',
                              style: TextStyle(
                                  color: Colors.black)),
                        ),
                        TextButton(
                          onPressed: () {
                            SocketMethods().endGame(context);
                          },
                          child: const Text(
                              'Retourner à la page d\'accueil',
                              style: TextStyle(
                                  color: Colors.black
                              )
                          ),
                        ),
                      ]
                  );
                });
          }else if(roomGlobal.endRound==false && roomGlobal.endGame==false){
            roomGlobal.endGame = true;
            showDialog(
                context: context,
                builder: (BuildContext context)
                {
                  return AlertDialog(
                      title: const Text("Résultat :"),
                      content: Text(
                          '${roomGlobal.player2.nickname} a gagné la partie!'
                      ),
                      backgroundColor: hexStringToColor("FFFFFF"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            SocketMethods().endGame(context);
                          },
                          child: const Text(
                              'Retourner à la page d\'accueil',
                              style: TextStyle(
                                  color: Colors.black
                              )
                          ),
                        ),
                      ]
                  );
                });
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
