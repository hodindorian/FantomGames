import 'package:email_validator/email_validator.dart';
import 'package:fantom_games/views/connection/sign_in_page.dart';
import 'package:flutter/material.dart';
import '../../connection/creating_user_in_api.dart';
import '../../reusable_widget/messsage_pop_up.dart';
import '../../reusable_widget/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

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
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
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

                    Container(
                      width: screenWidth * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        color: const Color(0xFF1B438F),
                      ),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(15),
                            child : Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Inscription : ',
                                  style: TextStyle(color: Colors.white, fontSize: screenWidth*0.02),
                                ),
                                usableTextField(
                                    "Entrez votre Mail", Icons.person_outline, false,
                                    _emailTextController,false, Colors.lightBlueAccent),
                                const SizedBox(
                                  height: 20,
                                ),
                                usableTextField(
                                    "Entrez votre pseudo", Icons.person_outline, false,
                                    _pseudoTextController,false, Colors.lightBlueAccent),
                                const SizedBox(
                                  height: 20,
                                ),
                                usableTextField(
                                    "Entrez votre mot de passe", Icons.lock_outline, true,
                                    _passwordTextController,false, Colors.lightBlueAccent),
                                const SizedBox(
                                  height: 20,
                                ),
                                usableTextField(
                                    "Confirmez votre mot de passe", Icons.lock_outline, true,
                                    _passwordVerifyTextController,false, Colors.lightBlueAccent),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextButton(
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
                                  onPressed: () async {
                                    try {
                                      if (_emailTextController.text.isEmpty) {
                                        showMessagePopUp(context, "Email manquant",
                                            "Veuillez rentrer votre mail", "FFFFFF");
                                      } else if (!EmailValidator.validate(_emailTextController.text)) {
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
                                                const SignInScreen(signupInfo: "Vous avez bien été inscrit ! Veuillez maintenant vous connectez.")
                                            ));
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
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ]
                      ),
                    ),
                  ]
              ),
            )
        )
      )
    );
  }
}