import 'package:fantom_games/model/global_account.dart';
import 'package:fantom_games/model/global_object.dart';
import 'package:fantom_games/model/tic-tac-toe/global_room_tictactoe.dart';
import 'package:fantom_games/views/connection/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/battleship/global_room_battleship.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AccountGlobal()),
          ChangeNotifierProvider(create: (_) => RoomGlobalTicTacToe()),
          ChangeNotifierProvider(create: (_) => RoomGlobalBattleShip()),
          ChangeNotifierProvider(create: (_) => GlobalObject()),
        ],
        child: const FantomGames(),
      )
  );
}

class FantomGames extends StatelessWidget {
  const FantomGames({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fantom Games',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SignInScreen(signupInfo: "Connexion :"),
      debugShowCheckedModeBanner: false,
    );
  }
}
