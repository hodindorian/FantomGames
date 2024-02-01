import 'package:fantom_games/views/tic-tac-toe/create_or_join_room_screen.dart';
import 'package:fantom_games/views/menu/profil.dart';
import 'package:fantom_games/reusable_widget/menu.dart';
import 'package:fantom_games/reusable_widget/table_success.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/global_account.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> joueurs = [];
  bool isMenuOpened = false;
  bool isSuccessOpened = false;
  late AccountGlobal user;
  
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

  @override
  void initState() {
    super.initState();
    user = Provider.of<AccountGlobal>(context, listen: false);

    for (int i = 1; i <= 20; i++) {
      joueurs.add('Joueur $i');
    }
  }

  List<Widget> generatePositionedWidgets(int numberOfWidgets,List<String> imagesPath,List<Widget> nextPages,List<String> texts,) {
    List<Widget> widgets = [];
    for (int i = 0; i < numberOfWidgets; i++) {
      double leftPosition = MediaQuery.of(context).size.width * 0.25 + i * MediaQuery.of(context).size.height * 0.4;
      widgets.add(
        Positioned(
          top: MediaQuery.of(context).size.height * 0.60,
          left: leftPosition,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => nextPages[i]),
              );
            },
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: Colors.black, width: 2.0),
                    image: DecorationImage(
                      image: AssetImage(imagesPath[i]),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  texts[i],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return widgets;
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
                  right: screenWidth*0.63,
                  top : screenHeight*0.02,
                  child:
                      Image.asset('assets/FantomGamesIcon.png', opacity: const AlwaysStoppedAnimation(.3))
                ),

                ...generatePositionedWidgets(3,['assets/games/tictactoe_logo.png', '', ''],[const CreateOrJoinRoomScreen(), const MainPage(title: ''), const MainPage(title: ''), const MainPage(title: '')],['Morpion', 'Texte 2', 'Texte 3']),
                Positioned(
                  top: screenHeight*0.04,
                  left: screenWidth*0.20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Fantom Games",
                        style: TextStyle(
                          fontFamily: 'Boog',
                          color: Colors.white,
                          fontSize: screenWidth * 0.13,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: screenHeight * 0,
                  left: screenWidth * 0,
                  child: Container(
                    width: screenWidth,
                    height: screenHeight * 0,
                    color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Bienvenue sur Fantom Games, là où gagner de l'argent est un plaisir !",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenHeight * 0.03,
                            backgroundColor: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Menu(),
                const TableSuccess(),
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
                Positioned(
                  top: screenHeight * 0.45,
                  left: screenWidth*0,
                  child: SizedBox(
                    width: screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "À quoi voulez-vous jouer ?",
                          style: TextStyle(
                            fontFamily: 'Boog',
                            color: Colors.white,
                            fontSize: screenHeight * 0.065,
                          ),
                        ),
                      ],
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