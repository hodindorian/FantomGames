import 'package:email_validator/email_validator.dart';
import 'package:fantom_games/connection/change_password_in_api.dart';
import 'package:fantom_games/views/connection/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:fantom_games/reusable_widget/method/messsage_pop_up.dart';
import 'package:fantom_games/reusable_widget/widget/text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _pseudoTextController = TextEditingController();

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
                        usableTextField(
                            "Entrez votre mail", Icons.person_outline, false,
                            _emailTextController,false,Colors.lightBlueAccent, 200.0,100),
                        const SizedBox(
                          height: 20,
                        ),
                        usableTextField(
                            "Entrez votre pseudo", Icons.person_outline, false,
                            _pseudoTextController,false,Colors.lightBlueAccent, 200.0,100),
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
                              if (_emailTextController.text.isEmpty) {
                                showMessagePopUp(context, "Email manquant",
                                    "Veuillez rentrer votre mail",
                                    "FFFFFF");
                              }
                              else if (!EmailValidator.validate(_emailTextController.text)) {
                                showMessagePopUp(context, "Email Incorrect",
                                    "Veuillez rentrer correctement votre mail",
                                    "FFFFFF");
                              } else if (_pseudoTextController.text.isEmpty) {
                                showMessagePopUp(context, "Pseudo manquant",
                                    "Veuillez rentrer votre pseudo", "FFFFFF");
                              } else {
                                changePasswordInApi(_emailTextController.text,_pseudoTextController.text)
                                    .then((String result) {
                                  if (result == "OK") {
                                    if (context.mounted) {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                          const SignInScreen(
                                              signupInfo: "Mail de confirmation bien envoyé ! Veuillez maintenant changer votre mot de passe et vous connectez.")
                                      ));
                                    }
                                  } else if (result == "no_pseudo_link") {
                                    if (context.mounted) {
                                      showMessagePopUp(
                                          context, "Utilisateur inconnu",
                                          "Ce mail n'est pas affecté à un utilisateur", "FFFFFF");
                                    }
                                  } else {
                                    if (context.mounted) {
                                      showMessagePopUp(
                                          context, "Erreur",
                                          result, "FFFFFF"
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
                            "Envoyer",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
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