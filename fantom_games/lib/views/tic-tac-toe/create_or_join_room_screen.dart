import 'package:flutter/material.dart';
import 'package:fantom_games/views/tic-tac-toe/loading.dart';
import 'package:fantom_games/views/tic-tac-toe/join_room_screen.dart';
import 'package:fantom_games/reusable_widget/text_field.dart';
import 'package:fantom_games/reusable_widget/menu.dart';
import 'package:fantom_games/reusable_widget/table_success.dart';
import '../../resources/tic-tac-toe/socket_methods.dart';
import 'package:provider/provider.dart';
import '../../model/global_account.dart';
import 'package:fantom_games/views/home/main_page.dart';
import 'package:fantom_games/views/menu/profil.dart';

class CreateOrJoinRoomScreen extends StatefulWidget {
  static String routeName = '/main-menu';
  static bool isSuccessOpened = false;

  const CreateOrJoinRoomScreen({super.key});

  @override
  CreateOrJoinRoomScreenState createState() => CreateOrJoinRoomScreenState();
}

class CreateOrJoinRoomScreenState extends State<CreateOrJoinRoomScreen> {
  final TextEditingController _gameIdController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();
  late AccountGlobal user;

  void createRoom(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => const Loading()
    ));
  }

  void profil(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => const Profil()
    ));
  }

  void accueil(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => const MainPage(title: 'Accueil')
    ));
  }

  void joinRoom(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => const JoinRoomScreen()
    ));
  }

  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccuredListener(context);
    _socketMethods.updatePlayersStateListener(context);
    user = Provider.of<AccountGlobal>(context, listen: false);

  }

  @override
  void dispose() {
    super.dispose();
    _gameIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: const Color(0xFF1B438F),
        child: Stack(
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
                  "Fantom games",
                  style: TextStyle(
                    fontFamily: 'Boog',
                    color: Colors.white,
                    fontSize: screenHeight * 0.24,
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0,
              left: screenWidth * 0,
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.06,
                color: const Color(0xFF003366),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Jeu du Morpion",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.03,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: screenWidth*0,
              right: screenHeight*0.01,
              child: Row(
                children: [
                  Text(user.pseudo, // profil.name
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                      width: screenHeight * 0.06,
                      height: screenHeight * 0.06,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue, // remplacer par profil.image
                      ),
                      child: ClipOval(
                        child: SizedBox(
                          width: screenHeight * 0.06,
                          height: screenHeight * 0.06,
                          child: Image.memory(user.image, fit: BoxFit.cover),
                        ),
                      )
                  ),
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                Positioned(
                  top: screenHeight * 0.4,
                  bottom: screenHeight * 0.20,
                  left: screenWidth * 0.25,
                  child: Container(
                    width: screenWidth * 0.2,
                    height: screenHeight * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(
                        color: Colors.black,
                        width: 3.0,
                      ),
                      image: const DecorationImage(
                        image: AssetImage('assets/games/tictactoe_logo.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const Menu(),
                Stack(
                  children: [
                    Positioned(
                      top: screenHeight * 0.52,
                      left: screenWidth * 0.50,
                      width: screenWidth * 0.2,
                      height: screenHeight * 0.30,
                      child: OverflowBox(
                        minWidth: 0.0,
                        maxWidth: double.infinity,
                        minHeight: 0.0,
                        maxHeight: double.infinity,
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF003366),
                            border: Border.all(
                              color: Colors.black,
                              width: 3.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Rejoindre une salle',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.02,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              usableTextField(
                                "Entrez le code",
                                Icons.room_preferences,
                                false,
                                _gameIdController,
                                false,
                                Colors.lightBlueAccent,
                                screenWidth * 0.18,
                                screenHeight * 0.07,
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              ElevatedButton(
                                onPressed: () => _socketMethods.joinRoom(user.pseudo, _gameIdController.text.toUpperCase().replaceAll('-', '')),
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(screenWidth * 0.18, screenHeight * 0.08),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  backgroundColor: Colors.blue,
                                ),
                                child: Text(
                                  'Rejoindre',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.02,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: screenHeight * 0.42,
                      left: screenWidth * 0.50,
                      width: screenWidth * 0.2,
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () => createRoom(context),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(color: Colors.black, width: 3.0),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              backgroundColor: const Color(0xFF003366),
                            ),
                            child: Text(
                              'Créer une Salle',
                              style: TextStyle(
                                fontSize: screenWidth * 0.02,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const TableSuccess(),
          ],
        ),
      ),
    );
  }
}