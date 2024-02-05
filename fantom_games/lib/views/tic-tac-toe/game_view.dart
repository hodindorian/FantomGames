import 'package:fantom_games/model/global_account.dart';
import 'package:fantom_games/model/tic-tac-toe/global_room.dart';
import 'package:fantom_games/reusable_widget/widget/menu.dart';
import 'package:fantom_games/reusable_widget/widget/navigation_bar_on_top.dart';
import 'package:fantom_games/reusable_widget/widget/profil_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fantom_games/resources/tic-tac-toe/socket_methods.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final SocketMethods _socketMethods = SocketMethods();
  late AccountGlobal user;

  @override
  void initState() {
    super.initState();
    _socketMethods.tappedListener(context);
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
    user = Provider.of<AccountGlobal>(context, listen: false);
  }

  void tapped(int index, RoomGlobal roomGlobal) {
    _socketMethods.tapGrid(
      index,
      roomGlobal.roomData['id'],
      roomGlobal.displayElements,
    );
  }


  @override
  Widget build(BuildContext context) {
    RoomGlobal roomGlobal = Provider.of<RoomGlobal>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: const Color(0xFF1B438F),
        child: Stack(
          children: [
            const NavigationBarOnTop(title: 'Jeu du morpion'),
            const ReusableMenu(color: Color(0xFF003366)),
            ProfilIcon(pseudo: user.pseudo, userImage: user.image),
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
                        Text(
                          roomGlobal.player1.nickname,
                          style: TextStyle(
                            fontSize: (screenWidth+screenHeight)*0.015,
                            fontFamily: 'Boog',
                            color: Colors.white
                          ),
                        ),
                        Text(
                          (roomGlobal.player1.points~/2).toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          roomGlobal.player2.nickname,
                          style: TextStyle(
                            fontSize: (screenWidth+screenHeight)*0.015,
                            fontFamily: 'Boog',
                            color: Colors.white
                          ),
                        ),
                        Text(
                          (roomGlobal.player2.points~/2).toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
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
            Positioned(
            top: screenHeight * 0.2,
            right: screenWidth * 0.08,
            child: Column(
              children: [
                Text(
                    "Votre profil : ",
                  style: TextStyle(
                    fontSize: (screenWidth+screenHeight)*0.015,
                    color: Colors.white
                  ),
                ),
                Container(
                  width: screenHeight * 0.3,
                  height: screenHeight * 0.3,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: ClipOval(
                    child: SizedBox(
                      width: screenHeight * 0.3,
                      height: screenHeight * 0.3,
                      child: user.image!=null || user.image==[]
                          ? Image.memory(user.image!, fit: BoxFit.cover)
                          : const CircularProgressIndicator(),
                    ),
                  ),
                ),
                Text(
                  user.pseudo,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: (screenWidth+screenHeight)*0.025,
                  ),
                ),
                Text(
                  "Argent du compte :",
                  style: TextStyle(
                      fontSize: (screenWidth+screenHeight)*0.015,
                      color: Colors.white
                  ),
                ),
                Row(
                  children: [
                    Text(
                      user.cryptoBalance.toString(),
                      style: TextStyle(
                        fontSize: (screenWidth + screenHeight) * 0.02,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: screenWidth*0.01),
                    Image.asset(
                      'assets/FantomGamesIcon.png',
                      width: screenWidth*0.045,
                      height: screenWidth*0.045,
                    ),
                  ],
                )

              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
