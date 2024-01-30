import 'package:flutter/material.dart';
import 'package:fantom_games/views/home/main_page.dart';
import 'package:fantom_games/views/menu/profil.dart';

class ReusableMenu extends StatelessWidget {
  final bool isMenuOpened;
  final Function() toggleMenu;
  final Function() goToAccueil;
  final Function() goToProfil;

  const ReusableMenu({super.key, 
    required this.isMenuOpened,
    required this.toggleMenu,
    required this.goToAccueil,
    required this.goToProfil,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.06,
      left: MediaQuery.of(context).size.width * 0.02,
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0),
          TextButton(
            onPressed: goToAccueil,
            child: const Text(
              'Accueil',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          TextButton(
            onPressed: goToProfil,
            child: const Text(
              'Profil',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                  ),
                ],
              ),
            ),
          ),
          // Add other menu items here
        ],
      ),
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool isMenuOpened = false;

  void toggleMenu() {
    setState(() {
      isMenuOpened = !isMenuOpened;
    });
  }

  void goToAccueil() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainPage(title: 'Accueil'),
      ),
    );
  }

  void goToProfil() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Profil(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 0,
          left: 0,
          child: InkWell(
            onTap: toggleMenu,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    isMenuOpened ? Icons.arrow_back : Icons.menu,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.height * 0.03,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isMenuOpened ? "Retour" : "Menu",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isMenuOpened)
          ReusableMenu(
            isMenuOpened: isMenuOpened,
            toggleMenu: toggleMenu,
            goToAccueil: goToAccueil,
            goToProfil: goToProfil,
          ),
      ],
    );
  }
}
