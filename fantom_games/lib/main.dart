import 'package:fantom_games/model/global_account.dart';
import 'package:fantom_games/model/global_object.dart';
import 'package:fantom_games/model/tic-tac-toe/global_room.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fantom_games/views/home/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AccountGlobal()),
          ChangeNotifierProvider(create: (_) => RoomGlobal()),
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
      home: const MainPage(title: ''),
      //home: const SignInScreen(signupInfo: ''),
      debugShowCheckedModeBanner: false,
    );
  }
}