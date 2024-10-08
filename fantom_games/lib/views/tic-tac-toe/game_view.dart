import 'package:universal_html/html.dart' as html;
import 'package:fantom_games/model/global_account.dart';
import 'package:fantom_games/model/tic-tac-toe/global_room_tictactoe.dart';
import 'package:fantom_games/reusable_widget/widget/navigation_bar_on_top.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fantom_games/resources/tic-tac-toe/socket_methods.dart';

class GameViewTicTacToe extends StatefulWidget {
  const GameViewTicTacToe({super.key});

  @override
  State<GameViewTicTacToe> createState() => _GameViewStateTicTacToe();
}

class _GameViewStateTicTacToe extends State<GameViewTicTacToe> {
  final SocketMethodsTicTacToe _socketMethods = SocketMethodsTicTacToe();
  late AccountGlobal user;
  late Widget res;
  bool hasLeftGame = false;

  @override
  void initState() {
    super.initState();
    _socketMethods.tappedListener(context);
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
    _socketMethods.clearBoardListener(context);
    _socketMethods.leaveGameListener(context);
    user = Provider.of<AccountGlobal>(context, listen: false);
  }

  void tapped(int index, RoomGlobalTicTacToe roomGlobal) {
    _socketMethods.tapGrid(
      index,
      roomGlobal.roomData['id'],
      roomGlobal.displayElements,
    );
  }

  @override
  Widget build(BuildContext context) {
    RoomGlobalTicTacToe roomGlobal = Provider.of<RoomGlobalTicTacToe>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    html.window.onBeforeUnload.listen((event) async {
      _socketMethods.leaveGame(context);
    });

    if(roomGlobal.player1.nickname == user.pseudo){
      roomGlobal.actualPlayer = roomGlobal.player1;
    }
    if(roomGlobal.player2.nickname == user.pseudo){
      roomGlobal.actualPlayer = roomGlobal.player2;
    }

    return Scaffold(
      body: Container(
        color: const Color(0xFF1B438F),
        child: Stack(
          children: [
            const NavigationBarOnTop(title: 'Jeu du morpion'),
            Positioned(
                right: screenWidth*0.65,
                top : screenHeight*0.02,
                child:
                Image.asset('assets/FantomGamesIcon.png', opacity: const AlwaysStoppedAnimation(.3))
            ),
            Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenWidth*0.025),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: !roomGlobal.endGame,
                          child: Text(
                            roomGlobal.player1.nickname,
                            style: TextStyle(
                                fontSize: (screenWidth+screenHeight)*0.015,
                                fontFamily: 'Boog',
                                color: Colors.white
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !roomGlobal.endGame,
                          child: Text(
                            (roomGlobal.player1.points~/2).toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: !roomGlobal.endGame,
                          child: Text(
                            roomGlobal.player2.nickname,
                            style: TextStyle(
                                fontSize: (screenWidth+screenHeight)*0.015,
                                fontFamily: 'Boog',
                                color: Colors.white
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !roomGlobal.endGame,
                          child: Text(
                            (roomGlobal.player2.points).toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: screenHeight * 0.6,
                  maxWidth: screenWidth * 0.28,
                  minHeight: screenHeight * 0.6,
                  minWidth: screenWidth * 0.28,
                ),
                child: Stack(
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: ValueNotifier(roomGlobal.endGame),
                      builder: (context, value, child) {
                        if (value) {
                          if(roomGlobal.player1.nickname == user.pseudo){
                            roomGlobal.actualPlayer = roomGlobal.player1;
                          }
                          if(roomGlobal.player2.nickname == user.pseudo){
                            roomGlobal.actualPlayer = roomGlobal.player2;
                          }

                          if (roomGlobal.endGame && roomGlobal.winner == roomGlobal.actualPlayer.playerType){
                            res = Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: (screenWidth + screenHeight) * 0.01),
                                child: Text(
                                  'Vous avez gagné la partie !',
                                  style: TextStyle(
                                    fontSize: (screenWidth + screenHeight) * 0.03,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                ),
                              ),
                            );
                          }else if (roomGlobal.endGame && roomGlobal.winner != roomGlobal.actualPlayer.playerType){
                            res = Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: (screenWidth + screenHeight) * 0.01),
                                child: Text(
                                  'Vous avez perdu... Dommage !',
                                  style: TextStyle(
                                    fontSize: (screenWidth + screenHeight) * 0.03,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                ),
                              ),
                            );
                          }
                        }else{
                          res = ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: screenHeight * 0.6,
                                maxWidth: screenWidth * 0.28,
                                minHeight: screenHeight * 0.6,
                                minWidth: screenWidth * 0.28
                            ),
                            child: AbsorbPointer(
                              absorbing: roomGlobal.roomData['turn']['socketID'] !=
                                  _socketMethods.socketClient.id,
                              child: GridView.builder(
                                itemCount: 9,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTapDown: (_) => tapped(index, roomGlobal),
                                    child: Container(
                                      margin: EdgeInsets.all(screenWidth*0.001),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: screenWidth*0.0035,
                                        ),
                                      ),
                                      child: Center(
                                        child: AnimatedSize(
                                          duration: const Duration(milliseconds: 200),
                                          child: Text(
                                            roomGlobal.displayElements[index],
                                            style: TextStyle(
                                              color: roomGlobal.displayElements[index].replaceAll(' ', '') == 'O'
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: (screenWidth+screenHeight)*0.04,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                        return res;
                      },
                    ),
                  ],
                ),
              ),
              if(roomGlobal.endRound==false && roomGlobal.endGame==false)
                Text(
                  'Au tour de ${roomGlobal.roomData['turn']['nickname']}',
                  style: TextStyle(
                    fontSize: (screenWidth+screenHeight)*0.015,
                    fontFamily: 'Boog',
                    color: Colors.white
                  ),
                ),
              Visibility(
                visible: roomGlobal.endRound,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _socketMethods.nextRound(context);
                    });
                  },
                  child: Text(
                    'Recommencer la partie',
                    style: TextStyle(
                      fontSize: (screenWidth+screenHeight)*0.015,
                      fontFamily: 'Boog',
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: roomGlobal.endRound,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _socketMethods.endGame(context);
                      roomGlobal.reset();
                    });
                  },
                  child: Text(
                    'Retourner à la page d\'accueil',
                    style: TextStyle(
                      fontSize: (screenWidth+screenHeight)*0.015,
                      fontFamily: 'Boog',
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: roomGlobal.endGame,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _socketMethods.endGame(context);
                      roomGlobal.reset();
                    });
                  },
                  child: Text(
                    'Retourner à la page d\'accueil',
                    style: TextStyle(
                      fontSize: (screenWidth+screenHeight)*0.015,
                      fontFamily: 'Boog',
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }
}
