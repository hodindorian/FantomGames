import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Profil extends StatefulWidget {
  static String routeName = '/profil';

  const Profil({super.key});

  @override
  ProfilState createState() => ProfilState();
}

class ProfilState extends State<Profil> {
  bool isMenuOpened = false;
  bool isSuccessOpened = false;

  void profil(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => const Profil()
    ));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: const Color(0xFF1B438F),
        //color: Colors.red,
        child : OrientationBuilder(
          builder: (context, orientation) {
            return Stack(
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
                          fontSize: screenHeight * 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.27,
                  left: screenWidth * 0,
                  child: Container(
                    width: screenWidth,
                    height: screenHeight * 0.06,
                    color: const Color(0xFF003366),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Page de profil",
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
                  top: screenHeight * 0.28,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isMenuOpened = !isMenuOpened;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            isMenuOpened ? Icons.arrow_back : Icons.menu,
                            color: Colors.white,
                            size: screenHeight * 0.03,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isMenuOpened ? "Retour" : "Accueil",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenHeight * 0.02,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (isMenuOpened)
                  Positioned(
                  top: screenHeight * 0.31,
                  left: screenWidth * 0.01,
                  /*child: Container(
                    width: orientation == Orientation.portrait ? 100 : 200,
                    height: listHeight,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),*/
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: screenHeight * 0.05),
                        TextButton(
                          onPressed: () => profil(context),
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
                        SizedBox(height: screenHeight * 0.05),
                        TextButton(
                          onPressed: () {
                            if (kDebugMode) {
                              print('Sécurité sélectionné');
                            }
                          },
                          child: const Text(
                            'Sécurité',
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
                        SizedBox(height: screenHeight * 0.05),
                        TextButton(
                          onPressed: () {
                            if (kDebugMode) {
                              print('Portefeuille sélectionné');
                            }
                          },
                          child: const Text(
                            'Portefeuille',
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
                        SizedBox(height: screenHeight * 0.05),
                        TextButton(
                          onPressed: () {
                            if (kDebugMode) {
                              print('Scoreboard sélectionné');
                            }
                          },
                          child: const Text(
                            'Scoreboard',
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
                      ],
                    ),
                ),
                Positioned(
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
                ),
                Positioned(
                  top: screenHeight * 0.35,
                  left: screenWidth * 0.2,
                  child: Container(
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Nom d\'utilisateur :',
                            style: TextStyle(fontSize: screenHeight * 0.02),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.3,
                          child: Container(
                            height: screenHeight * 0.08,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Ici le nom d\'utilisateur',
                                style: TextStyle(fontSize: screenHeight * 0.03),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Avatar :',
                            style: TextStyle(fontSize: screenHeight * 0.02),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.3,
                          child: Container(
                            height: screenHeight * 0.08,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Ici le chemin de l\'image',
                                style: TextStyle(fontSize: screenHeight * 0.03),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Logique pour changer d'image ici
                          },
                          child: const Text('Changer d\'image'),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Nom :',
                            style: TextStyle(fontSize: screenHeight * 0.02),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.3,
                          child: Container(
                            height: screenHeight * 0.08,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Ici le nom',
                                style: TextStyle(fontSize: screenHeight * 0.03),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Prénom :',
                            style: TextStyle(fontSize: screenHeight * 0.02),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.3,
                          child: Container(
                            height: screenHeight * 0.08,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Ici le prénom',
                                style: TextStyle(fontSize: screenHeight * 0.03),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Numéro de téléphone :',
                            style: TextStyle(fontSize: screenHeight * 0.02),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.3,
                          child: Container(
                            height: screenHeight * 0.08,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Ici le numéro de téléphone',
                                style: TextStyle(fontSize: screenHeight * 0.03),
                                textAlign: TextAlign.start,
                              ),
                            ),
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