import 'package:fantom_games/model/battleship/boats.dart';
import 'package:fantom_games/model/battleship/global_room_battleship.dart';
import 'package:fantom_games/model/global_account.dart';
import 'package:fantom_games/resources/battleship/socket_methods.dart';
import 'package:fantom_games/reusable_widget/widget/navigation_bar_on_top.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;


class GameViewBattleShip extends StatefulWidget {
  const GameViewBattleShip({super.key});

  @override
  State<GameViewBattleShip> createState() => _GameViewStateBattleShip();
}

class _GameViewStateBattleShip extends State<GameViewBattleShip> {
  final SocketMethodsBattleShip _socketMethods = SocketMethodsBattleShip();
  late AccountGlobal user;
  late Widget res;
  bool getBoats = false;


  @override
  void initState() {
    super.initState();
    _socketMethods.tappedListener(context);
    _socketMethods.updateRoomListener(context);
    _socketMethods.endGameListener(context);
    _socketMethods.getBoatsListener(context);
    user = Provider.of<AccountGlobal>(context, listen: false);
  }

  void tapped(int index, RoomGlobalBattleShip roomGlobal) {
    if(roomGlobal.actualPlayer.nbPlayer ==  1){
      _socketMethods.tapGrid(
        index,
        roomGlobal.roomData['id'],
        roomGlobal.displayElementsPlayer2,
      );
    }else if(roomGlobal.actualPlayer.nbPlayer == 2){
      _socketMethods.tapGrid(
        index,
        roomGlobal.roomData['id'],
        roomGlobal.displayElementsPlayer1,
      );
    }

  }
  @override
  Widget build(BuildContext context) {
    RoomGlobalBattleShip roomGlobal = Provider.of<RoomGlobalBattleShip>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    List<int> actualCase = [1,1];

    html.window.onBeforeUnload.listen((event) async {
      _socketMethods.leaveGame(context);
    });

    return Scaffold(
      body: Container(
        color: const Color(0xFF1B438F),
        child: Stack(
          children: [
            const NavigationBarOnTop(title: 'Bataille Navale'),
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
                      padding: EdgeInsets.all((screenWidth+screenHeight)*0.015),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: !roomGlobal.endGame,
                            child: Text(
                              '',
                              style: TextStyle(
                                  fontSize: (screenWidth+screenHeight)*0.015,
                                  fontFamily: 'Boog',
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(),
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

                            if (roomGlobal.endGame && roomGlobal.winner == roomGlobal.actualPlayer.nbPlayer){
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
                            }else if (roomGlobal.endGame && roomGlobal.winner != roomGlobal.actualPlayer.nbPlayer){
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
                            if(roomGlobal.actualPlayer.nbPlayer==1){
                              res = Padding(
                                padding: EdgeInsets.symmetric(horizontal: (screenWidth+screenHeight) * 0.05),
                                child: Row(
                                  children : [
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxHeight: (screenHeight+screenWidth) * 0.22,
                                          maxWidth: (screenHeight+screenWidth) * 0.22,
                                          minHeight: (screenHeight+screenWidth) * 0.22,
                                          minWidth: (screenHeight+screenWidth) * 0.22
                                      ),
                                      child: AbsorbPointer(
                                        absorbing: roomGlobal.roomData['turn']['socketID'] !=
                                            _socketMethods.socketClient.id,
                                        child: GridView.builder(
                                          itemCount: 100,
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 10,
                                          ),
                                          itemBuilder: (BuildContext context, int index) {
                                            actualCase = [(index ~/ 10), (index % 10)];
                                            BoatsAndColor boatsAndColor = roomGlobal.actualPlayer.boats.isBoatAtPosition(actualCase);
                                            return GestureDetector(
                                              child: Container(
                                                margin: EdgeInsets.all((screenWidth+screenHeight)*0.001),
                                                decoration: BoxDecoration(
                                                  color:boatsAndColor.isBoatHere ? boatsAndColor.colorOfTheBoat : Colors.transparent,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: (screenWidth+screenHeight)*0.00035,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: AnimatedSize(
                                                    duration: const Duration(milliseconds: 200),
                                                    child: Text(
                                                      roomGlobal.displayElementsPlayer1[index],
                                                      style: TextStyle(
                                                        color: roomGlobal.displayElementsPlayer1[index].replaceAll(' ', '') == 'X'
                                                            ? Colors.purpleAccent
                                                            : Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: (screenWidth+screenHeight)*0.014,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: (screenWidth + screenHeight) * 0.05),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxHeight: (screenHeight+screenWidth) * 0.22,
                                          maxWidth: (screenHeight+screenWidth) * 0.22,
                                          minHeight: (screenHeight+screenWidth) * 0.22,
                                          minWidth: (screenHeight+screenWidth) * 0.22
                                      ),
                                      child: AbsorbPointer(
                                        absorbing: roomGlobal.roomData['turn']['socketID'] !=
                                            _socketMethods.socketClient.id,
                                        child: GridView.builder(
                                          itemCount: 100,
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 10,
                                          ),
                                          itemBuilder: (BuildContext context, int index) {
                                            actualCase = [(index ~/ 10), (index % 10)];
                                            return GestureDetector(
                                              onTapDown: (_) => tapped(index, roomGlobal),
                                              child: Container(
                                                margin: EdgeInsets.all((screenWidth+screenHeight)*0.001),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: (screenWidth+screenHeight)*0.00035,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: AnimatedSize(
                                                    duration: const Duration(milliseconds: 200),
                                                    child: Text(
                                                      roomGlobal.displayElementsPlayer2[index],
                                                      style: TextStyle(
                                                        color: roomGlobal.displayElementsPlayer2[index].replaceAll(' ', '') == 'X'
                                                            ? Colors.red
                                                            : Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: (screenWidth+screenHeight)*0.014,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }else if(roomGlobal.actualPlayer.nbPlayer==2) {
                              res = Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: (screenWidth + screenHeight) *
                                        0.05),
                                child: Row(
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxHeight: (screenHeight +
                                              screenWidth) * 0.22,
                                          maxWidth: (screenHeight +
                                              screenWidth) * 0.22,
                                          minHeight: (screenHeight +
                                              screenWidth) * 0.22,
                                          minWidth: (screenHeight +
                                              screenWidth) * 0.22
                                      ),
                                      child: AbsorbPointer(
                                        absorbing: roomGlobal
                                            .roomData['turn']['socketID'] !=
                                            _socketMethods.socketClient.id,
                                        child: GridView.builder(
                                          itemCount: 100,
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 10,
                                          ),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            actualCase =
                                            [(index ~/ 10), (index % 10)];
                                            BoatsAndColor boatsAndColor = roomGlobal
                                                .actualPlayer.boats
                                                .isBoatAtPosition(actualCase);
                                            return GestureDetector(
                                              child: Container(
                                                margin: EdgeInsets.all(
                                                    (screenWidth +
                                                        screenHeight) * 0.001),
                                                decoration: BoxDecoration(
                                                  color: boatsAndColor
                                                      .isBoatHere
                                                      ? boatsAndColor
                                                      .colorOfTheBoat
                                                      : Colors.transparent,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: (screenWidth +
                                                        screenHeight) * 0.00035,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: AnimatedSize(
                                                    duration: const Duration(
                                                        milliseconds: 200),
                                                    child: Text(
                                                      roomGlobal
                                                          .displayElementsPlayer2[index],
                                                      style: TextStyle(
                                                        color: roomGlobal
                                                            .displayElementsPlayer2[index]
                                                            .replaceAll(
                                                            ' ', '') == 'X'
                                                            ? Colors.purpleAccent
                                                            : Colors.black,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize:(screenWidth+screenHeight)*0.014,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: (screenWidth + screenHeight) *
                                            0.05),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxHeight: (screenHeight +
                                              screenWidth) * 0.22,
                                          maxWidth: (screenHeight +
                                              screenWidth) * 0.22,
                                          minHeight: (screenHeight +
                                              screenWidth) * 0.22,
                                          minWidth: (screenHeight +
                                              screenWidth) * 0.22
                                      ),
                                      child: AbsorbPointer(
                                        absorbing: roomGlobal
                                            .roomData['turn']['socketID'] !=
                                            _socketMethods.socketClient.id,
                                        child: GridView.builder(
                                          itemCount: 100,
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 10,
                                          ),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            actualCase =
                                            [(index ~/ 10), (index % 10)];
                                            return GestureDetector(
                                              onTapDown: (_) =>
                                                  tapped(index, roomGlobal),
                                              child: Container(
                                                margin: EdgeInsets.all(
                                                    (screenWidth +
                                                        screenHeight) * 0.001),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: (screenWidth +
                                                        screenHeight) * 0.00035,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: AnimatedSize(
                                                    duration: const Duration(
                                                        milliseconds: 200),
                                                    child: Text(
                                                      roomGlobal
                                                          .displayElementsPlayer1[index],
                                                      style: TextStyle(
                                                        color: roomGlobal
                                                            .displayElementsPlayer1[index]
                                                            .replaceAll(
                                                            ' ', '') == 'X'
                                                            ? Colors.red
                                                            : Colors.black,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: (screenWidth+screenHeight)*0.014,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                          return res;
                        },
                      ),
                    ],
                  ),
                ),
                if(roomGlobal.endGame==false)
                  Text(
                    'Au tour de ${roomGlobal.roomData['turn']['nickname']}',
                    style: TextStyle(
                        fontSize: (screenWidth+screenHeight)*0.015,
                        fontFamily: 'Boog',
                        color: Colors.white
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
