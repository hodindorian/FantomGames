import 'package:fantom_games/resources/battleship/socket_methods.dart';
import 'package:fantom_games/reusable_widget/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fantom_games/model/global_account.dart';
import 'package:fantom_games/reusable_widget/widget/button.dart';

class JoinRoomScreenBattleShip extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreenBattleShip ({super.key});

  @override
  State<JoinRoomScreenBattleShip> createState() => _JoinRoomScreenStateBattleShip ();
}

class _JoinRoomScreenStateBattleShip  extends State<JoinRoomScreenBattleShip > {
  final TextEditingController _gameIdController = TextEditingController();
  late final String _name;
  final SocketMethodsBattleShip _socketMethods = SocketMethodsBattleShip();

  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccuredListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _name = Provider.of<AccountGlobal>(context, listen: false).pseudo;
  }

  @override
  void dispose() {
    super.dispose();
    _gameIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Rejoindre une Room",
              style: TextStyle(
                fontSize: 70,
              ),
            ),
            const SizedBox(height: 20),
            usableTextField("Entrez le numéro de Room", Icons.room_preferences, false, _gameIdController, false, Colors.lightBlueAccent, 200.0,200),
            const SizedBox(height: 15),
            CustomButton(
              onTap: () => _socketMethods.joinRoom(_name,_gameIdController.text.toUpperCase().replaceAll('-', '')),
              text: 'Rejoindre',
            ),
          ],
        ),
      ),
    );
  }
}
