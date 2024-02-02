import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/global_account.dart';
import 'hex_string_to_color.dart';

class VerifyingIdentity extends StatefulWidget {
  const VerifyingIdentity({super.key});

  @override
  VerifyingIdentityState createState() => VerifyingIdentityState();
}

class VerifyingIdentityState extends State<VerifyingIdentity> {

  late AccountGlobal user;
  late String lastname;
  late String firstname;
  late String phoneNumber;
  late Uint8List cardVerso;
  late Uint8List cardRecto;

  Future<List<Object>> _getRectoVersoCard() async {
    List<Uint8List> card = [];
    List<String> error = [];
    FilePickerResult? recto = await FilePickerWeb.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (recto != null) {
      cardRecto = recto.files.single.bytes!;
      FilePickerResult? verso = await FilePickerWeb.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
      );
      if (verso != null) {
        cardVerso = verso.files.single.bytes!;
        card.add(cardRecto);
        card.add(cardVerso);
        return card;
      } else {
        if (kDebugMode) {
          print("Sélection annulée");
          error.add("cancelled");
          return error;
        }
      }
    } else {
      if (kDebugMode) {
        print("Sélection annulée");
        error.add("cancelled");
        return error;
      }
    }
    error.add("error");
    return error;
  }

  @override
  void initState() {
    super.initState();
    user = Provider.of<AccountGlobal>(context, listen: false);;

  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Positioned(
      top: screenHeight * 0.75,
      left: screenWidth * 0.52,
      child: ElevatedButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: const Text("Déjà Connecté"),
                  content: const Text(
                      "Vous êtes déjà connecté autre part, cliquez sur le bouton 'Se Déconnecter' vous vous déconnectez de votre ancien appareil."),
                  backgroundColor: hexStringToColor(
                      "FFFFFF"),
                  actions: [
                    TextButton(
                      onPressed: () {},
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
            }
          );
        },
        child: Text(
          "Go !",
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidth*0.02
          )
        ),
      ),
    );
  }

}