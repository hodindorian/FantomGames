import 'package:crypto/crypto.dart';
import 'package:fantom_games/reusable_widget/cookie_managing.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<String> connectingUserToApi(String pseudo, String password, bool stayConnected) async {
  try {
    String sha256Password = sha256.convert(utf8.encode(password)).toString();
    Uri uri = Uri.https('codefirst.iut.uca.fr',
        '/containers/fantom_games-deploy_api/userConnection/$pseudo/$sha256Password');
    http.Response response = await http.get(uri,
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
      },
    );
    var rep = response.body;
    rep = rep.replaceAll(' ', '');
    if (response.statusCode != 200) {
      return "error";
    } else if (rep == "OK") {
      if (stayConnected){
        saveCookie("auth", pseudo);
      }
      return "OK";
    } else if (rep=="nouser"){
      return "no user";
    } else {
      return "wrong_password";
    }
  }catch(e) {
    return e.toString();
  }
}

