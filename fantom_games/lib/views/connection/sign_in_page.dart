import 'package:fantom_games/reusable_widget/session_managing.dart';
import 'package:fantom_games/views/connection/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:fantom_games/connection/connection_user_to_api.dart';
import '../../connection/try_connection_with_id_in_api.dart';
import '../../reusable_widget/messsage_pop_up.dart';
import '../../reusable_widget/text_field.dart';
import '../home/main_page.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

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
    getItemSession("id").then((result1) async {
      int id = result1;
      getItemSession("pseudo").then((result2) async {
        String pseudo = result2;
        if (pseudo.isNotEmpty || id != 0) {
          if (await tryConnectionWithSession(id, pseudo)) {
            if (context.mounted) {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPage(title: 'Accueil'),
                  ),
                );
              });
            }
          }
        }
        });
    });
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
                                final response = await connectingUserToApi(
                                    _pseudoTextController.text,
                                    _passwordTextController.text,
                                    _isStayLoggedIn);
                                if (response == "OK") {
                                  if (context.mounted) {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                        const MainPage(
                                            title: 'Accueil')));
                                  }
                                } else if (response == "no user") {
                                  if (context.mounted) {
                                    showMessagePopUp(
                                        context, "Utilisateur inconnu",
                                        "Ce pseudo n'existe pas", "FFFFFF");
                                  }
                                } else if (response == "wrong_password") {
                                  if (context.mounted) {
                                    showMessagePopUp(
                                        context, "Mot de passe incorrect",
                                        "Votre mot de passe est incorrect", "FFFFFF");
                                  }
                                } else {
                                  if (context.mounted) {
                                    showMessagePopUp(
                                        context, "Erreur", response, "FFFFFF");
                                  }
                                }
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