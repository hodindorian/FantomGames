import 'package:fantom_games/views/connection/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FantomGames());
}


class FantomGames extends StatelessWidget {
  const FantomGames({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fantom Games',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const SignInScreen(),
    );
  }
}

