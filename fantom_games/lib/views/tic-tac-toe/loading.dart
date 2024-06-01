import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fantom_games/model/global_account.dart';
import 'package:fantom_games/resources/tic-tac-toe/socket_methods.dart';

class LoadingTicTacToe extends StatefulWidget {
  const LoadingTicTacToe({super.key});

  @override
  State<LoadingTicTacToe> createState() => _LoadingStateTicTacToe();
}

class _LoadingStateTicTacToe extends State<LoadingTicTacToe> {
  final SocketMethodsTicTacToe _socketMethods = SocketMethodsTicTacToe();
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
