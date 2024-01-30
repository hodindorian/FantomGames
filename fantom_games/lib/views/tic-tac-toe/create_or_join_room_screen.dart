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
  late final String _name;
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
    _name = Provider.of<AccountGlobal>(context, listen: false).pseudo;
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
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/fantom_background_2.png'),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                    Colors.blue.withOpacity(0.3),
                    BlendMode.dstATop,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/FantomGamesIcon.png',
                    width: screenWidth * 0.2,
                    height: screenHeight * 0.2,
                  ),
                  Text(
                    "Fantom games",
                    style: TextStyle(
                      fontFamily: 'Mistral',
                      color: Colors.white,
                      fontSize: screenWidth * 0.1,
                    ),
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
                Positioned(
                  top: screenHeight * 0.27,
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
                                onPressed: () => _socketMethods.joinRoom(_name, _gameIdController.text.toUpperCase().replaceAll('-', '')),
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
                /*Positioned(
                  top: screenHeight * 0.27,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isSuccessOpened = !isSuccessOpened;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            isSuccessOpened ? Icons.cancel : Icons.inventory_sharp,
                            color: Colors.white,
                            size: screenHeight * 0.05,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (isSuccessOpened)
                  Positioned(
                  top: screenHeight * 0.33,
                  right: 0,
                  child: Container(
                    height: screenHeight * 0.35,
                    width: screenWidth * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 3.0,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.005, left: screenWidth * 0.002),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              double iconSize = constraints.maxHeight * 0.1;
                              return Icon(
                                Icons.star,
                                color: Colors.black,
                                size: iconSize,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  double fontsize = constraints.maxHeight * 0.1;
                                  return Text(
                                    "Le succès",
                                    style: TextStyle(
                                      fontSize: fontsize,
                                      color: Colors.black,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            LayoutBuilder(
                              builder: (context, constraints) {
                                double fontSize = constraints.maxHeight * 0.1;
                                double iconSize = constraints.maxHeight * 0.1;
                                return Row(
                                  children: [
                                    Text(
                                      "1",
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Image.asset(
                                      "assets/FantomGamesIcon.png",
                                      height: iconSize,
                                      width: iconSize,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),*/
          ],
        ),
      ),
    );
  }
}