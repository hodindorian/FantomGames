import 'package:fantom_games/model/tic-tac-toe/global_room.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Lobby extends StatefulWidget {
  const Lobby({super.key, required this.roomID});
  final String roomID;

  @override
  State<Lobby> createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  late TextEditingController roomIdController;
  late String roomId1;
  late String roomId2;

  @override
  void initState() {
    super.initState();
    roomIdController = TextEditingController(text: Provider.of<RoomGlobal>(context, listen: false).roomData['id']);
    roomId1 = widget.roomID.substring(0, 4);
    roomId2 = widget.roomID.substring(4, 8);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    roomIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
          color: const Color(0xFF1B438F),
          child : OrientationBuilder(
            builder: (context, orientation) {
              return Stack(
                children: <Widget>[
                  Positioned(
                      right: screenWidth*0.68,
                      top : screenHeight*0.02,
                      child:
                      Image.asset('assets/FantomGamesIcon.png', opacity: const AlwaysStoppedAnimation(.3))
                  ),
                  AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.21, top: screenHeight*0.025),
                            child: Text(
                              "En attente d'un joueur${'.' * (_animationController.value * 4).floor()}",
                              style: TextStyle(
                                fontFamily: 'Boog',
                                color: Colors.white,
                                fontSize: screenHeight * 0.15,
                              ),
                            ),
                          ),
                        );
                      }
              ),
              Align(
              alignment: Alignment.center,
              child: Padding(
              padding: EdgeInsets.only(top: screenHeight*0.025),
                      child: SelectableText(
                        "Votre numéro de room est : $roomId1-$roomId2 ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenHeight *0.05
                        ),
                      ),
                    ),
                  ),

                ],
              );
            },
          ),
        )
    );
  }
}

