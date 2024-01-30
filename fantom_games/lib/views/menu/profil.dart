import 'dart:convert';
import 'package:fantom_games/connection/adding_info_in_api.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fantom_games/views/home/main_page.dart';
import 'package:fantom_games/reusable_widget/menu.dart';
import 'package:fantom_games/reusable_widget/table_success.dart';
import 'package:provider/provider.dart';
import '../../model/global_account.dart';
import '../../reusable_widget/hex_string_to_color.dart';
import '../../reusable_widget/messsage_pop_up.dart';

class Profil extends StatefulWidget {
  static String routeName = '/profil';

  const Profil({super.key});

  @override
  ProfilState createState() => ProfilState();
}

class ProfilState extends State<Profil> {

  bool isSuccessOpened = false;
  late AccountGlobal user;
  late String lastname;
  late String firstname;
  late String phoneNumber;
  String image = '';
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  Future<String> _openFilePicker() async {

    FilePickerResult? result = await FilePickerWeb.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      Uint8List? file = result.files.single.bytes;
      image = base64Encode(file!);
      return image;
    } else {
      if (kDebugMode) {
        print("Sélection annulée");
      }
      return "";
    }

  }

  @override
  void initState() {
    super.initState();
    user = Provider.of<AccountGlobal>(context, listen: false);

    if(user.lastname==null){
      lastname = "Non défini";
    }else{
      lastname= user.lastname!;
    }
    if(user.firstname==null){
      firstname = "Non défini";
    }else{
      firstname = user.firstname!;
    }
    if(user.phoneNumber==null){
      phoneNumber = "Non défini";
    }else{
      phoneNumber = user.phoneNumber!;
    }
  }


  void profil(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => const Profil()
    ));
  }

  void accueil(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => const MainPage(title: 'Accueil')
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
                const Menu(),
                 const TableSuccess(),
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
                  ), 
                ),
                Positioned(
                  top: screenHeight * 0.37,
                  left: screenWidth * 0.22,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, left: 16.0),
                        child: Text(
                          'Nom d\'utilisateur :',
                          style: TextStyle(fontSize: screenHeight * 0.02),
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.2,
                        height: screenHeight * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4.0, left: 16.0),
                          child: Text(
                            user.pseudo,
                            style: TextStyle(fontSize: screenHeight * 0.03),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.49,
                  left: screenWidth * 0.22,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, left: 16.0),
                        child: Text(
                          'Avatar :',
                          style: TextStyle(fontSize: screenHeight * 0.02),
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.2,
                        height: screenHeight * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4.0, left: 16.0),
                          child: Text(
                            'Lien de l\'image ici',
                            style: TextStyle(fontSize: screenHeight * 0.03),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.58,
                  left: screenWidth * 0.22,
                  child: ElevatedButton(
                    onPressed: () {
                      _openFilePicker().then((String res) async {
                        if(res!="") {
                          changeImageInApi(user.pseudo, res).then((
                              List<dynamic> myList) async {
                            if (myList[0] == "Unexpected error") {
                              showMessagePopUp(
                                  context,
                                  "Erreur Innatendue",
                                  "Votre photo de profil n'as pas pu être changé.",
                                  "FFFFFF"
                              );
                            } else {
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
                                      myList[8]
                                  );
                                  image = user.image!;
                                });
                              }
                              showMessagePopUp(
                                  context, "Changement réussi !",
                                  "Votre photo de profil a bien été changé !",
                                  "FFFFFF"
                              );
                            }
                          });
                        }
                      });

                    },
                    child: const Text('Changer d\'image'),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.37,
                  left: screenWidth * 0.52,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, left: 16.0),
                        child: Text(
                          'Nom :',
                          style: TextStyle(fontSize: screenHeight * 0.02),
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.2,
                        height: screenHeight * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4.0, left: 16.0),
                          child: Text(
                            lastname,
                            style: TextStyle(fontSize: screenHeight * 0.03),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.4555,
                  left: screenWidth * 0.52,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context)
                          {
                            return AlertDialog(
                                title: const Text("Changer le Nom"),
                                content: TextField(
                                          controller: _lastNameController,
                                          decoration: const InputDecoration(hintText: "Veuillez rentrer votre nom"),
                                ),
                                backgroundColor: hexStringToColor("FFFFFF"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      changeLastNameInApi(user.pseudo,_lastNameController.text).then((List<dynamic> myList) async {
                                        Navigator.of(context).pop();
                                        if(myList[0] == "Unexpected error"){
                                          showMessagePopUp(
                                              context,
                                              "Erreur Innatendue",
                                              "Votre nom n'as pas pu être changé.",
                                              "FFFFFF"
                                          );
                                        }else {
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
                                                  myList[8]
                                              );
                                              lastname = user.lastname!;
                                            });
                                          }
                                          showMessagePopUp(
                                              context, "Changement réussi !",
                                              "Votre nom a bien été changé !",
                                              "FFFFFF"
                                          );
                                        }
                                      });
                                    },
                                    child: const Text(
                                        'Valider',
                                        style: TextStyle(
                                            color: Colors.black)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Annuler',
                                        style: TextStyle(
                                            color: Colors.black
                                        )
                                    ),
                                  ),
                                ]
                            );
                          });
                    },
                    child: const Text('Modifier'),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.49,
                  left: screenWidth * 0.52,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, left: 16.0),
                        child: Text(
                          'Prénom :',
                          style: TextStyle(fontSize: screenHeight * 0.02),
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.2,
                        height: screenHeight * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4.0, left: 16.0),
                          child: Text(
                            firstname,
                            style: TextStyle(fontSize: screenHeight * 0.03),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.575,
                  left: screenWidth * 0.52,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context)
                          {
                            return AlertDialog(
                                title: const Text("Changer le Prénom"),
                                content: TextField(
                                  controller: _firstNameController,
                                  decoration: const InputDecoration(hintText: "Veuillez rentrer votre prénom"),
                                ),
                                backgroundColor: hexStringToColor("FFFFFF"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      changeFirstNameInApi(user.pseudo,_firstNameController.text).then((List<dynamic> myList) async {
                                        Navigator.of(context).pop();
                                        if(myList[0] == "Unexpected error"){
                                          showMessagePopUp(
                                              context,
                                              "Erreur Innatendue",
                                              "Votre prénom n'as pas pu être changé.",
                                              "FFFFFF"
                                          );
                                        }else {
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
                                                  myList[8]
                                              );
                                              firstname = user.firstname!;
                                            });
                                          }
                                          showMessagePopUp(
                                              context, "Changement réussi !",
                                              "Votre prénom a bien été changé !",
                                              "FFFFFF"
                                          );
                                        }
                                      });
                                    },
                                    child: const Text(
                                        'Valider',
                                        style: TextStyle(
                                            color: Colors.black)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Annuler',
                                        style: TextStyle(
                                            color: Colors.black
                                        )
                                    ),
                                  ),
                                ]
                            );
                          });
                    },
                    child: const Text('Modifier'),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.615,
                  left: screenWidth * 0.52,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, left: 16.0),
                        child: Text(
                          'Numéro de téléphone :',
                          style: TextStyle(fontSize: screenHeight * 0.02),
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.2,
                        height: screenHeight * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4.0, left: 16.0),
                          child: Text(
                            phoneNumber,
                            style: TextStyle(fontSize: screenHeight * 0.03),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.70,
                  left: screenWidth * 0.52,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context)
                          {
                            return AlertDialog(
                                title: const Text("Changer le numéro de téléphone"),
                                content: TextField(
                                  controller: _phoneNumberController,
                                  decoration: const InputDecoration(hintText: "Veuillez rentrer votre numéro de téléphone"),
                                ),
                                backgroundColor: hexStringToColor("FFFFFF"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      changePhoneInApi(user.pseudo,_phoneNumberController.text).then((List<dynamic> myList) async {
                                        Navigator.of(context).pop();
                                        if(myList[0] == "Unexpected error"){
                                          showMessagePopUp(
                                              context,
                                              "Erreur Innatendue",
                                              "Votre numéro de téléphone n'as pas pu être changé.",
                                              "FFFFFF"
                                          );
                                        }else {
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
                                              phoneNumber = user.phoneNumber!;
                                            });
                                          }
                                          showMessagePopUp(
                                              context, "Changement réussi !",
                                              "Votre numéro de téléphone a bien été changé !",
                                              "FFFFFF"
                                          );
                                        }
                                      });
                                    },
                                    child: const Text(
                                        'Valider',
                                        style: TextStyle(
                                            color: Colors.black)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Annuler',
                                        style: TextStyle(
                                            color: Colors.black
                                        )
                                    ),
                                  ),
                                ]
                            );
                          });
                    },
                    child: const Text('Modifier'),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.75,
                  left: screenWidth * 0.52,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, left: 16.0),
                        child: Text(
                          'Carte d\'identité :',
                          style: TextStyle(fontSize: screenHeight * 0.02),
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.2,
                        height: screenHeight * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4.0, left: 16.0),
                          child: Text(
                            'Carte d\'identité déjà validé !',
                            style: TextStyle(fontSize: screenHeight * 0.03),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
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