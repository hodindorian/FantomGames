import 'package:fantom_games/model/tic-tac-toe/global_room.dart';
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

  @override
  void initState() {
    super.initState();
    _socketMethods.tappedListener(context);
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
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

    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        roomGlobal.player1.nickname,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                maxHeight: MediaQuery.of(context).size.height * 0.7,
                maxWidth: 500,
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
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Center(
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            child: Text(
                              roomGlobal.displayElements[index],
                              style: TextStyle(
                                  color: roomGlobal.displayElements[index].replaceAll(' ','') == 'O'
                                      ? Colors.red
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 100,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 40,
                                      color:
                                      roomGlobal.displayElements[index].replaceAll(' ','') == 'O'
                                          ? Colors.red
                                          : Colors.black,
                                    ),
                                  ]),
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
                  'Au tour de ${roomGlobal.roomData['turn']['nickname']}'
              ),
          ],
        ),
      ),
    );
  }
}
