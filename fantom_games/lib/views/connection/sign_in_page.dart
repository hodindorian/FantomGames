import 'package:fantom_games/reusable_widget/session_managing.dart';
import 'package:fantom_games/views/connection/sign_up_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fantom_games/connection/connection_user_to_api.dart';
import 'package:provider/provider.dart';
import '../../connection/try_connection_with_id_in_api.dart';
import '../../model/global_account.dart';
import '../../reusable_widget/messsage_pop_up.dart';
import '../../reusable_widget/text_field.dart';
import '../home/main_page.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.signup});

  final bool signup;

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {

  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _pseudoTextController = TextEditingController();
  bool _isStayLoggedIn = false;

  @override
  void initState() {
    super.initState();
    /*
    if(signup){
      showMessagePopUp(
          context, "Compte bien créé !",
          "Veuillez maintenant vous connectez grâce à la page de connection",
          "00FF00"
      );
    }
    */
    try {
      getItemSession("id").then((result1) async {
        if (result1 != null) {
          String id = result1;
          getItemSession("pseudo").then((result2) async {
            if(result2 != null) {
              String ?pseudo = result2;
              if (pseudo!.isNotEmpty) {
                tryConnectionWithSession(id, pseudo).then((List<dynamic> myList) {
                  if (myList[0]) {
                    if (context.mounted) {
                      setState(() {
                        var user = Provider.of<AccountGlobal>(
                            context, listen: false);
                        user.updateAccount(myList[1],myList[2],myList[3],myList[4],myList[5],myList[6],myList[7]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const MainPage(title: 'Accueil'),
                          ),
                        );
                      });
                    }
                  }
                });
              }
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
                        const SizedBox(
                          height: 30,
                        ),
                        usableTextField(
                            "Entrez votre pseudo", Icons.person_outline, false,
                            _pseudoTextController),
                        const SizedBox(
                          height: 20,
                        ),
                        usableTextField(
                            "Entrez votre mot de passe", Icons.lock_outline,true,
                            _passwordTextController),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text("\nVous n'avez pas de compte ?",
                            style: TextStyle(color: Colors.white)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (
                                    context) => const SignUpScreen()));
                          },
                          child: const Text(
                            " Inscription",
                            style: TextStyle(color: Colors.white,
                                fontSize: 20),
                          ),
                        ),
                        const Text(""),
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
                              } else if (_passwordTextController.text.length <
                                  6) {
                                showMessagePopUp(
                                    context, "Mot de passe incorrect",
                                    "Veuillez rentrer correctement votre mot de passe",
                                    "FFFFFF");
                              } else {
                                connectingUserToApi(_pseudoTextController.text,_passwordTextController.text,_isStayLoggedIn)
                                .then((List<dynamic> myList) {
                                  if (myList[0] == "OK") {
                                      if (context.mounted) {
                                        var user = Provider.of<AccountGlobal>(
                                            context, listen: false);
                                        user.updateAccount(myList[1],myList[2],myList[3],myList[4],myList[5],myList[6],myList[7]);
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>
                                            const MainPage(
                                                title: 'Accueil')));
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
                                    } else {
                                      if (context.mounted) {
                                        showMessagePopUp(
                                            context, "Erreur", myList[0], "FFFFFF");
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
                  ),
                )
            )
        )
    );
  }
}