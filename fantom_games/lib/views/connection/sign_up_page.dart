import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../../connection/creating_user_in_api.dart';
import '../../reusable_widget/messsage_pop_up.dart';
import '../../reusable_widget/text_field.dart';
import '../home/main_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _passwordVerifyTextController = TextEditingController();
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
                      const SizedBox(
                        height: 20,
                      ),
                      usableTextField(
                          "Entrez votre Mail", Icons.person_outline, false,_emailTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      usableTextField(
                          "Entrez votre pseudo", Icons.person_outline, false,_pseudoTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      usableTextField(
                          "Entrez votre mot de passe", Icons.lock_outline, true,_passwordTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      usableTextField(
                          "Confirmez votre mot de passe", Icons.lock_outline, true,_passwordVerifyTextController),
                      const SizedBox(
                        height: 5,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.red)
                        ),
                        onPressed: () async {
                          try {
                            if (_emailTextController.text.isEmpty) {
                              showMessagePopUp(context, "Email manquant",
                                  "Veuillez rentrer votre mail", "FFFFFF");
                            } else if (!EmailValidator.validate(
                                _emailTextController.text)) {
                              showMessagePopUp(context, "Email Incorrect",
                                  "Veuillez rentrer correctement votre mail",
                                  "FFFFFF");
                            } else if (_pseudoTextController.text.isEmpty) {
                              showMessagePopUp(context, "Pseudo manquant",
                                  "Veuillez rentrer votre pseudo", "FFFFFF");
                            } else if (_passwordTextController.text.isEmpty) {
                              showMessagePopUp(context, "Mot de passe manquant",
                                  "Veuillez rentrer votre mot de passe",
                                  "FFFFFF");
                            } else if (_passwordVerifyTextController.text
                                .isEmpty) {
                              showMessagePopUp(context, "Mot de passe manquant",
                                  "Veuillez confirmez votre mot de passe",
                                  "FFFFFF");
                            } else if (_passwordTextController.text.length <
                                6) {
                              showMessagePopUp(
                                  context, "Mot de passe incorrect",
                                  "Veuillez mettre un de minimum 6 caractères",
                                  "FFFFFF");
                            } else if (_passwordVerifyTextController.text !=
                                _passwordTextController.text) {
                              showMessagePopUp(
                                  context, "Mot de passe non identiques",
                                  "Les deux mots de passe ne sont pas identiques",
                                  "FFFFFF");
                            } else {
                              String response = await creatingUserInApi(
                                  _emailTextController.text,
                                  _pseudoTextController.text,
                                  _passwordTextController.text);
                              response = response.replaceAll(' ', '');
                              if (response == "OK") {
                                if (context.mounted) {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                      const MainPage(
                                          title: 'Accueil')));
                                }
                              } else if (response == "pseudoalreadyuse") {
                                if (context.mounted) {
                                  showMessagePopUp(
                                      context, "Pseudo déjà utilisé",
                                      "Ce pseudo est déjà utilisé par un utilisateur",
                                      "FFFFFF");
                                }
                              } else if (response == "emailalreadyuse") {
                                if (context.mounted) {
                                  showMessagePopUp(context, "Mail déjà utilisé",
                                      "Cet email déjà utilisé par un utilisateur",
                                      "FFFFFF");
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
                              showMessagePopUp(
                                  context, "Erreur", e.toString(), "FFFFFF");
                            }
                          }
                        }, child: const Text(
                              "Créer le compte",
                              style: TextStyle(
                                color: Colors.white,
                              fontSize: 20,
                              ),
                          ),
                      ),
                    ]
                ),
              ),
            )
        )
      )
    );
  }
}