import 'package:flutter/material.dart';

class LobbyPageReusable extends StatelessWidget {
  final AnimationController animationController;
  final String roomId1;
  final String roomId2;

  const LobbyPageReusable({
    super.key,
    required this.animationController,
    required this.roomId1,
    required this.roomId2,
  });



  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;



    return Scaffold(
        body: Container(
          color: const Color(0xFF1B438F),
          child: OrientationBuilder(
            builder: (context, orientation) {
              return Stack(
                children: <Widget>[
                  Positioned(
                      right: screenWidth * 0.68,
                      top: screenHeight * 0.02,
                      child:
                      Image.asset('assets/FantomGamesIcon.png',
                          opacity: const AlwaysStoppedAnimation(.3))
                  ),
                  AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.21,
                                top: screenHeight * 0.025),
                            child: Text(
                              "En attente d'un joueur${'.' *
                                  (animationController.value * 4).floor()}",
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
                      padding: EdgeInsets.only(top: screenHeight * 0.025),
                      child: SelectableText(
                        "Votre numéro de room est : $roomId1-$roomId2 ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenHeight * 0.05
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