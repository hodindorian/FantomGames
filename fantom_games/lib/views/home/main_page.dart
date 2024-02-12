import 'package:fantom_games/views/battleship/create_or_join_room_screen.dart';
import 'package:fantom_games/views/tic-tac-toe/create_or_join_room_screen.dart';
import 'package:fantom_games/views/menu/profil.dart';
import 'package:fantom_games/reusable_widget/widget/menu.dart';
import 'package:fantom_games/reusable_widget/widget/table_success.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fantom_games/model/global_account.dart';
import 'package:fantom_games/reusable_widget/widget/main_page_games.dart';
import 'package:fantom_games/reusable_widget/widget/profil_icon.dart';

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

                ...generatePositionedWidgets(3,['games/tictactoe_logo.png', 'games/battleship.png', ''],[const CreateOrJoinRoomScreen(), const CreateOrJoinRoomScreenBattleShip(), const MainPage(title: ''), const MainPage(title: '')],['Morpion', 'Bataille Navale', 'Texte 3'],context),
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
                const ReusableMenu(color:Color(0xFF1B438F)),
                const TableSuccess(),
                ProfilIcon(pseudo: user.pseudo,userImage: user.image),
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