import 'package:fantom_games/connection/disconnect_in_api.dart';
import 'package:fantom_games/reusable_widget/hex_string_to_color.dart';
import 'package:fantom_games/reusable_widget/session_managing.dart';
import 'package:fantom_games/views/connection/forgot_password_page.dart';
import 'package:fantom_games/views/connection/sign_up_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fantom_games/connection/connection_user_to_api.dart';
import 'package:provider/provider.dart';
import '../../connection/try_connection_with_id_in_api.dart';
import '../../model/global_account.dart';
import '../../model/global_object.dart';
import '../../reusable_widget/messsage_pop_up.dart';
import '../../reusable_widget/text_field.dart';
import '../home/main_page.dart';

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
                          setState(() {
                            user.updateAccount(
                                myList[1],
                                myList[2],
                                myList[3],
                                myList[4],
                                myList[5],
                                myList[6],
                                myList[7]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const MainPage(title: 'Accueil'),
                              ),
                            );
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
            decoration: BoxDecoration(
              color: const Color(0xFF1B438F),
              image: DecorationImage(
                image: const AssetImage('../assets/fantom_background_2.png'),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                  Colors.blue.withOpacity(0.3),
                  BlendMode.dstATop
                ),
              ),
            ),
            child: OverflowBox(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        left: 20,
                        child: Row(
                          children: [
                            Image(
                              image: const AssetImage(
                                '../assets/FantomGamesIcon.png',
                              ),
                              width: screenWidth * 0.2,
                              height: screenHeight * 0.2,
                            ),

                            Text(
                              "Fantom Games",
                              style: TextStyle(
                                fontFamily: 'Mistral',
                                color: Colors.white,
                                fontSize: screenWidth * 0.1,
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
                              height: screenHeight * 0.3,
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
                                        padding: const EdgeInsets.all(15),
                                        child : Column(
                                        //Champs texte du formulaire
                                        children: <Widget>[
                                          Text(widget.signupInfo,
                                            style: const TextStyle(color: Colors.blue, fontSize: 30),
                                          ),
                                          Text(
                                              'Connexion : ',
                                              style: TextStyle(color: Colors.white, fontSize: screenWidth*0.02),
                                          ),
                                          usableTextField(
                                            "Entrez votre pseudo", Icons.person_outline, false,
                                            _pseudoTextController,false,Colors.lightBlueAccent),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          usableTextField(
                                            "Entrez votre mot de passe", Icons.lock_outline,true,
                                            _passwordTextController,false,Colors.lightBlueAccent),
                                          const SizedBox(
                                            height: 5,
                                          ),

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

                                              const Text("Rester connecté",
                                                  style: TextStyle(color: Colors.white)
                                              ),
                                            ],
                                          ),

                                          //Bouton "Mot de passe oublié"
                                          TextButton(
                                            style: ButtonStyle(
                                                foregroundColor: MaterialStateProperty.all<Color>(
                                                    Colors.red)
                                            ),
                                            onPressed: () async {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (
                                                      context) => const ForgotPasswordScreen())
                                              );
                                            },
                                            child: const Text(
                                              "Mot de passe oublié ?",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),

                                          const Text("\nVous n'avez pas de compte ?",
                                              style: TextStyle(color: Colors.white)),

                                          //Bouton "Inscription"
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (
                                                      context) => const SignUpScreen())
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(
                                                Colors.lightBlueAccent,
                                              ),
                                              side: MaterialStateProperty.all(
                                                const BorderSide(
                                                  color: Colors.black,
                                                  width: 2.0,
                                                ),
                                              ),
                                            ),
                                            child: const Text(
                                              " Inscription",
                                              style: TextStyle(color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),

                                          const SizedBox(height: 20,
                                          ),

                                          //Bouton de connexion
                                          TextButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(
                                                Colors.lightBlueAccent,
                                              ),
                                              side: MaterialStateProperty.all(
                                                const BorderSide(
                                                  color: Colors.black,
                                                  width: 2.0,
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
                                                        user.updateAccount(myList[1],myList[2],myList[3],myList[4],myList[5],myList[6],myList[7]);
                                                        Navigator.push(context, MaterialPageRoute(
                                                            builder: (context) =>
                                                            const MainPage(
                                                                title: 'Accueil'))
                                                        );
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
                                            child: const Text(
                                              "Se connecter",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 40,
                                              ),
                                            ),
                                          ),
                                        const SizedBox(height: 20,)
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
            )
        )
    );
  }
}