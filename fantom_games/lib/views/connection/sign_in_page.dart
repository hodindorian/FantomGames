import 'package:fantom_games/connection/disconnect_in_api.dart';
import 'package:fantom_games/reusable_widget/method/hex_string_to_color.dart';
import 'package:fantom_games/reusable_widget/method/session_managing.dart';
import 'package:fantom_games/views/connection/forgot_password_page.dart';
import 'package:fantom_games/views/connection/sign_up_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fantom_games/connection/connection_user_to_api.dart';
import 'package:provider/provider.dart';
import 'package:fantom_games/connection/get_image_in_api.dart';
import 'package:fantom_games/connection/try_connection_with_id_in_api.dart';
import 'package:fantom_games/model/global_account.dart';
import 'package:fantom_games/model/global_object.dart';
import 'package:fantom_games/reusable_widget/method/messsage_pop_up.dart';
import 'package:fantom_games/reusable_widget/widget/text_field.dart';
import 'package:fantom_games/views/home/main_page.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.signupInfo});
  final String signupInfo;

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {

  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _pseudoTextController = TextEditingController();
  late AccountGlobal user;
  late GlobalObject object;
  bool _isStayLoggedIn = false;


  @override
  void initState() {

    super.initState();
    user = Provider.of<AccountGlobal>(context, listen: false);
    object = Provider.of<GlobalObject>(context, listen: false);
    try {
      getItemSession("id").then((result1) async {
        if (result1 != null) {
          String id = result1;
          getItemSession("pseudo").then((result2) async {
            if(result2 != null) {
              String ?pseudo = result2;
              getItemSession("idComputer").then((result3) async {
                if (result3 != null) {
                  String ?idComputer = result3.toString();
                  if (pseudo!.isNotEmpty && idComputer.isNotEmpty) {
                    tryConnectionWithSession(id, pseudo, idComputer).then((List<
                        dynamic> myList) {
                      if (myList[0]) {
                        if (context.mounted) {
                          getImageInApi(result2).then((Uint8List? newImage) async {
                            setState(() {
                              user.updateAccount(
                                myList[1],
                                myList[2],
                                myList[3],
                                myList[4],
                                myList[5],
                                myList[6],
                                myList[7],
                                newImage,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const MainPage(title: 'Accueil'),
                                ),
                              );
                            });
                          });
                        }
                      }else{
                        if(myList[1] == ""){

                        }
                      }
                    });
                  }
                }
              });
            }
          });
        }
      });
    }catch (e) {
      if (kDebugMode){
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
          color: const Color(0xFF1B438F),
          child: Stack(
          children: [
            Positioned(
              right: screenWidth*0.67,
              top : screenHeight*0.02,
              child:
                Image.asset('assets/FantomGamesIcon.png', opacity: const AlwaysStoppedAnimation(.3))
            ),
            OverflowBox(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: screenHeight*0,
                        left: screenWidth*0.20,
                        child: Row(
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
                        )
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.35,
                            ),
                            Container(
                              width: screenWidth * 0.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Bords arrondis
                                border: Border.all(
                                  color: Colors.black, // Couleur des bordures noires
                                  width: 2.0, // Épaisseur des bordures
                                ),
                                color: const Color(0xFF1B438F),
                              ),
                              child : Column(
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.all(screenWidth*0.02),
                                        child : Column(
                                        //Champs texte du formulaire
                                        children: <Widget>[
                                          Text(widget.signupInfo,
                                            style: TextStyle(color: Colors.white, fontSize: screenWidth*0.017),
                                          ),
                                          usableTextField(
                                            "Entrez votre pseudo", Icons.person_outline, false,
                                            _pseudoTextController,false,Colors.lightBlueAccent, screenWidth*0.4, screenHeight*0.07),

                                          usableTextField(
                                            "Entrez votre mot de passe", Icons.lock_outline,true,
                                            _passwordTextController,false,Colors.lightBlueAccent, screenWidth*0.4, screenHeight*0.07),
                                          //Checkbox pour rester connecté
                                          Row(
                                            children: <Widget>[
                                              Checkbox(
                                                value: _isStayLoggedIn,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    _isStayLoggedIn = newValue!;
                                                  });
                                                },
                                                checkColor: Colors.white,
                                                activeColor: Colors.blue,
                                              ),

                                              Text("Rester connecté",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: screenWidth*0.01)
                                              ),
                                            ],
                                          ),

                                          //Bouton "Mot de passe oublié"
                                          TextButton(
                                            style: ButtonStyle(
                                                foregroundColor: WidgetStateProperty.all<Color>(Colors.red)
                                            ),
                                            onPressed: () async {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (
                                                      context) => const ForgotPasswordScreen())
                                              );
                                            },
                                            child: Text(
                                              "Mot de passe oublié ?",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: screenWidth*0.01,
                                              ),
                                            ),
                                          ),

                                          Text("\nVous n'avez pas de compte ?",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: screenWidth*0.01
                                              )
                                          ),

                                          //Bouton "Inscription"
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (
                                                      context) => const SignUpScreen())
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty.all<Color>(Colors.lightBlueAccent,),
                                              minimumSize: WidgetStateProperty.all<Size>(Size(screenWidth*0.08, screenHeight*0.05)),
                                              side: WidgetStateProperty.all(
                                                const BorderSide(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              " Inscription",
                                              style: TextStyle(color: Colors.white,
                                                  fontSize: screenWidth*0.015),
                                            ),
                                          ),
                                          SizedBox(height: screenHeight*0.01),
                                          //Bouton de connexion
                                          TextButton(
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty.all<Color>(Colors.lightBlueAccent),
                                              minimumSize: WidgetStateProperty.all<Size>(Size(screenWidth*0.17, screenHeight*0.07)),
                                              maximumSize: WidgetStateProperty.all<Size>(Size(screenWidth*0.17, screenHeight*0.07)),
                                              side: WidgetStateProperty.all(
                                              const BorderSide(
                                                color: Colors.black,
                                                )
                                              )
                                            ),
                                            onPressed: () async {
                                              try {
                                                if (_pseudoTextController.text.isEmpty) {
                                                  showMessagePopUp(context, "Pseudo manquant",
                                                      "Veuillez rentrer votre pseudo", "FFFFFF");
                                                } else if (_passwordTextController.text.isEmpty) {
                                                  showMessagePopUp(
                                                      context, "Mot de passe manquant",
                                                      "Veuillez rentrer votre mot de passe",
                                                      "FFFFFF");
                                                } else if (_passwordTextController.text.length < 6) {
                                                  showMessagePopUp(
                                                      context, "Mot de passe incorrect",
                                                      "Veuillez rentrer correctement votre mot de passe",
                                                      "FFFFFF");
                                                } else {
                                                  connectingUserToApi(_pseudoTextController.text,_passwordTextController.text,_isStayLoggedIn, context)
                                                      .then((List<dynamic> myList) {
                                                    if (myList[0] == "OK") {
                                                      if (context.mounted) {
                                                        getImageInApi(_pseudoTextController.text).then((Uint8List? newImage) async {
                                                          user.updateAccount(
                                                            myList[1],
                                                            myList[2],
                                                            myList[3],
                                                            myList[4],
                                                            myList[5],
                                                            myList[6],
                                                            myList[7],
                                                            newImage,
                                                          );
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                const MainPage(title: 'Accueil')
                                                            )
                                                          );
                                                        });
                                                      }
                                                    } else if (myList[0] == "no user") {
                                                      if (context.mounted) {
                                                        showMessagePopUp(
                                                            context, "Utilisateur inconnu",
                                                            "Ce pseudo n'existe pas", "FFFFFF");
                                                      }
                                                    } else if (myList[0] == "wrong_password") {
                                                      if (context.mounted) {
                                                        showMessagePopUp(
                                                            context, "Mot de passe incorrect",
                                                            "Votre mot de passe est incorrect", "FFFFFF");
                                                      }
                                                    } else if (myList[0] == "already connected"){
                                                      if (context.mounted) {
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext context)
                                                            {
                                                              return AlertDialog(
                                                                  title: const Text("Déjà Connecté"),
                                                                  content: const Text(
                                                                      "Vous êtes déjà connecté autre part, cliquez sur le bouton 'Se Déconnecter' vous vous déconnectez de votre ancien appareil."),
                                                                  backgroundColor: hexStringToColor(
                                                                      "FFFFFF"),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        disconnectInApi(
                                                                            _pseudoTextController
                                                                                .text).then((
                                                                            res) async {
                                                                          String result = res;
                                                                          if (result == "") {
                                                                            Navigator.of(context)
                                                                                .pop();
                                                                            showMessagePopUp(
                                                                                context,
                                                                                "Déconnexion réussie",
                                                                                "Vous pouvez vous connecter",
                                                                                "FFFFFF"
                                                                            );
                                                                            object.alreadyConnected =
                                                                            false;
                                                                          } else {
                                                                            showMessagePopUp(
                                                                                context, "Erreur",
                                                                                result, "FFFFFF"
                                                                            );
                                                                          }
                                                                        });
                                                                      },
                                                                      child: const Text(
                                                                          'Se déconnecter',
                                                                          style: TextStyle(
                                                                              color: Colors.black)),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                      child: const Text('Fermer',
                                                                          style: TextStyle(
                                                                              color: Colors.black)),
                                                                    ),
                                                                  ]
                                                              );
                                                            });
                                                      }
                                                    } else {
                                                      if (context.mounted) {
                                                        showMessagePopUp(
                                                            context, "Erreur",
                                                            myList[0], "FFFFFF"
                                                        );
                                                      }
                                                    }
                                                  });
                                                }
                                              }catch(e){
                                                if (context.mounted) {
                                                  showMessagePopUp(context, "Erreur",
                                                      e.toString(), "FFFFFF");
                                                }
                                              }
                                            },
                                            child: Text(
                                              "Se connecter",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: screenWidth*0.022,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ),
            ),
          ],
        )
      ),
    );
  }
}