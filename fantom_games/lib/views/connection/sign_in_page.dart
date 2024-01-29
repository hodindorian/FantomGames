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
                                myList[7],
                                myList[8],
                            );
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
    return Scaffold(
        body: Container(
            color: Colors.blue,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                    child: Column(
                      children: <Widget>[
                        Text(widget.signupInfo,
                          style: const TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        usableTextField(
                            "Entrez votre pseudo", Icons.person_outline, false,
                            _pseudoTextController,false,Colors.lightBlueAccent, 200.0,100),
                        const SizedBox(
                          height: 20,
                        ),
                        usableTextField(
                            "Entrez votre mot de passe", Icons.lock_outline,true,
                            _passwordTextController,false,Colors.lightBlueAccent,200.0,100),
                        const SizedBox(
                          height: 5,
                        ),
                        TextButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.red)
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
                                        user.updateAccount(myList[1],myList[2],myList[3],myList[4],myList[5],myList[6],myList[7],myList[8]);
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
                        const Text("Rester connecté",
                            style: TextStyle(color: Colors.white)
                        ),
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
                        const SizedBox(height: 5,),
                        const Text("\nVous n'avez pas de compte ?",
                            style: TextStyle(color: Colors.white)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (
                                    context) => const SignUpScreen())
                            );
                          },
                          child: const Text(
                            " Inscription",
                            style: TextStyle(color: Colors.white,
                                fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 20,)
                      ],
                    ),
                  ),
                )
            )
        )
    );
  }
}