import 'package:flutter/material.dart';
import '../../connection/connection_user_to_api.dart';
import '../../reusable_widget/messsage_pop_up.dart';
import '../../reusable_widget/text_field.dart';
import '../home/main_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
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
                        height: 30,
                      ),
                      usableTextField(
                          "Entrez votre pseudoMail", Icons.person_outline, false,_pseudoTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      usableTextField(
                          "Entrez votre mot de passe", Icons.lock_outline, true,_passwordTextController),
                      const SizedBox(
                        height: 5,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.red)
                        ),
                        onPressed: () async {
                          if (_pseudoTextController.text.isEmpty) {
                            showMessagePopUp(context, "Email manquant",
                                "Veuillez rentrer votre mail", "FFFFFF");
                          } else if (_passwordTextController.text.isEmpty) {
                            showMessagePopUp(context, "Mot de passe manquant",
                                "Veuillez rentrer votre mot de passe", "FFFFFF");
                          } else
                          if (_passwordTextController.text.length < 6) {
                            showMessagePopUp(context, "Mot de passe incorrect",
                                "Veuillez rentrer correctement votre mot de passe","FFFFFF");
                          } else {
                            final response = await connectingUserToApi(_pseudoTextController.text,_passwordTextController.text);
                            if(response=="OK") {
                              if (context.mounted) {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const MainPage(
                                    title: 'Acceuil')));
                              }
                            }else{
                              if(context.mounted){
                                showMessagePopUp(context, "Erreur", response, "FFFFFF");
                              }
                            }
                            }
                          }, child: const Text(
                              "Se connecter",
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