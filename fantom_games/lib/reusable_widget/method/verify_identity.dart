import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:provider/provider.dart';
import 'package:fantom_games/model/global_account.dart';
import 'hex_string_to_color.dart';
import 'package:image/image.dart' as img;
import 'messsage_pop_up.dart';


class VerifyingIdentity extends StatefulWidget {
  final bool isAlreadyVerified;

  const VerifyingIdentity({super.key, required this.isAlreadyVerified});

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
  late Uint8List selfieUint8List;
  //final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  Future<img.Image> _getRectoCard() async {
    FilePickerResult? recto = await FilePickerWeb.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (recto != null) {
      cardRecto = recto.files.single.bytes!;
      return img.decodeImage(cardRecto)!;
    } else {
      if (kDebugMode) {
        print("Sélection annulée1");
      }
    }
    throw Exception("Error");
  }

  Future<img.Image> _getVersoCard() async {
    FilePickerResult? verso = await FilePickerWeb.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (verso != null) {
      cardRecto = verso.files.single.bytes!;
      return img.decodeImage(cardRecto)!;
    } else {
      if (kDebugMode) {
        print("Sélection annulée2");
      }
    }
    throw Exception("Error");
  }



  Future<bool> verifyIdentity(img.Image cardRectInfo) async {
    try {
      /*
      final recognizedText = await _textRecognizer.processImage(InputImage.fromBytes(
            bytes: cardRecto,
            inputImageData:
              InputImageData(
                size: Size(cardRectInfo.width.toDouble(),cardRectInfo.height.toDouble()),
                imageRotation: InputImageRotation.rotation0deg,
                inputImageFormat: InputImageFormat.nv21,
                planeData: [],
              ), metadata: null
        )
      );

       */
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    user = Provider.of<AccountGlobal>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
        top: screenHeight * 0.75,
        left: screenWidth * 0.53,
        child: Text(
              "Vérification carte d'identité : ",
              style: TextStyle(
                color : Colors.black,
                fontSize: screenHeight*0.02,
              )
              ,
            ),
        ),
        if(widget.isAlreadyVerified)
          Positioned(
            top: screenHeight * 0.78,
            left: screenWidth * 0.53,
            child: Text(
              "Carte d'identité déjà validée ! ",
              style: TextStyle(
                  color : Colors.black,
                  fontSize: screenHeight*0.03
              ),
            ),
          ),
        if(!widget.isAlreadyVerified)
          Positioned(
            top: screenHeight * 0.78,
            left: screenWidth * 0.53,
            child: ElevatedButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: const Text("Vérification de l'identité :"),
                          content: const Text(
                              "Veuillez préparer deux fichiers images (jpg, jpeg ou png) de votre recto-verso d'identité. Veuillez donner en premier le recto, puis le verso."),
                          backgroundColor: hexStringToColor(
                              "FFFFFF"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Pas encore prêt",
                                  style: TextStyle(
                                      color: Colors.black)),
                            ),
                            TextButton(
                              onPressed: () async {
                                try {
                                  _getRectoCard().then((img.Image recto) {
                                    Navigator.of(context).pop();
                                    verifyIdentity(recto);
                                  });
                                  _getVersoCard().then((img.Image verso){
                                    Navigator.of(context).pop();
                                    verifyIdentity(verso);
                                  });
                                }on Exception catch (_) {
                                  Navigator.of(context).pop();
                                  showMessagePopUp(
                                      context,
                                      "Erreur Innatendue",
                                      "Votre vérification d'identité à génerer une erreur",
                                      "FFFFFF"
                                  );
                                }
                              },
                              child: const Text(
                                  "C'est bon !",
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
          ),
        ],
    );
  }
}


