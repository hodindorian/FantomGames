import 'package:fantom_games/connection/adding_info_in_api.dart';
import 'package:fantom_games/connection/get_image_in_api.dart';
import 'package:fantom_games/reusable_widget/Method/verify_identity.dart';
import 'package:fantom_games/reusable_widget/Widget/profil_icon.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fantom_games/views/home/main_page.dart';
import 'package:fantom_games/reusable_widget/Widget/menu.dart';
import 'package:fantom_games/reusable_widget/Widget/table_success.dart';
import 'package:provider/provider.dart';
import '../../model/global_account.dart';
import '../../reusable_widget/Method/hex_string_to_color.dart';
import '../../reusable_widget/Method/messsage_pop_up.dart';
import '../../reusable_widget/Widget/navigation_bar_on_top.dart';

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
  late Uint8List image;
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  Future<Object> _openFilePicker() async {

    FilePickerResult? result = await FilePickerWeb.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      image = result.files.single.bytes!;
      return image;
    } else {
      if (kDebugMode) {
        print("Sélection annulée");
      }
      return false;
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
    image = user.image;
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
        child : OrientationBuilder(
          builder: (context, orientation) {
            return Stack(
              children: <Widget>[
                Positioned(
                    right: screenWidth*0.68,
                    top : screenHeight*0.02,
                    child:
                      Image.asset('assets/FantomGamesIcon.png', opacity: const AlwaysStoppedAnimation(.3))
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.21, top: screenHeight*0.025),
                    child: Text(
                      "Fantom games",
                      style: TextStyle(
                        fontFamily: 'Boog',
                        color: Colors.white,
                        fontSize: screenHeight * 0.24,
                      ),
                    ),
                  ),
                ),
                const NavigationBarOnTop(title : 'Page de profil'),
                ProfilIcon(pseudo: user.pseudo, userImage: user.image),
                const ReusableMenu(color:Color(0xFF003366)),
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
                        width: screenHeight * 0.15,
                        height: screenHeight * 0.15,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: ClipOval(
                          child: SizedBox(
                            width: screenHeight * 0.15,
                            height: screenHeight * 0.15,
                            child: user.image.isNotEmpty
                                ? Image.memory(user.image, fit: BoxFit.cover)
                                : const CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.68,
                  left: screenWidth * 0.22,
                  child: ElevatedButton(
                    onPressed: () {
                      _openFilePicker().then((Object res) async {
                        if(res is Uint8List) {
                          changeImageInApi(user.pseudo, res).then((List<dynamic> myList) async {
                            if (myList[0] == "Unexpected error") {
                              showMessagePopUp(
                                  context,
                                  "Erreur Innatendue",
                                  "Votre photo de profil n'as pas pu être changé.",
                                  "FFFFFF"
                              );
                            }else if(myList[0] == "CantChangeImage") {
                              showMessagePopUp(
                                context,
                                "Photo incorrecte",
                                "Votre photo de profil n'as pas pu être changé, l'image n'est pas pris en charge",
                                "FFFFFF"
                              );
                            } else {
                              if (context.mounted) {
                                getImageInApi(user.pseudo).then((Uint8List newImage) async {
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
                                    image = user.image;
                                  });
                                  showMessagePopUp(
                                      context, "Changement réussi !",
                                      "Votre photo de profil a bien été changé !",
                                      "FFFFFF"
                                  );
                                });
                              }
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
                const VerifyingIdentity(isAlreadyVerified: false),
              ],
            );
          },
        ),
      )
    );
  }
}