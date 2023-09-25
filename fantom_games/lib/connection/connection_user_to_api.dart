import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<String> connectingUserToApi(String pseudo, String password) async {
  String sha256Password = sha256.convert(utf8.encode(password)).toString();
  Uri uri = Uri.https('codefirst.iut.uca.fr',
    '/containers/fantom_games-deploy_api/getUserPassword/$pseudo');
  http.Response response = await http.get(uri,
    headers: <String, String>{
      'Access-Control-Allow-Origin': '*',
    },
  );
  try {
    var rep = jsonDecode(response.body);
    if (response.statusCode != 200) {
      return "error";
    } else if (rep['password'] == sha256Password) {
      return "OK";
    } else {
      return "wrong_password";
    }
  }on Error catch(_){
    return "no user";
  }
}

