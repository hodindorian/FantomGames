import 'package:fantom_games/resources/battleship/socket_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fantom_games/model/global_account.dart';

class LoadingBattleShip  extends StatefulWidget {
  const LoadingBattleShip ({super.key});

  @override
  State<LoadingBattleShip > createState() => _LoadingStateBattleShip ();
}

class _LoadingStateBattleShip  extends State<LoadingBattleShip > {
  final SocketMethodsBattleShip _socketMethods = SocketMethodsBattleShip();
  late AccountGlobal user;


  @override
  void initState() {
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
    user = Provider.of<AccountGlobal>(context, listen: false);
    _socketMethods.createRoom(user.pseudo);

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
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.21, top: screenHeight*0.025),
                    child: Text(
                      "Veuillez Patienter...",
                      style: TextStyle(
                        fontFamily: 'Boog',
                        color: Colors.white,
                        fontSize: screenHeight * 0.24,
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
