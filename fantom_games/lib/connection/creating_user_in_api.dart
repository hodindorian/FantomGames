import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:fantom_games/reusable_widget/method/salt_hash_password.dart';

Future<String> creatingUserInApi(String email,String pseudo, String password) async {
  try {

    String hashSaltPassword = hashPassword(password);
    Map<String, String> requestBody = {
      'email': email,
      'pseudo': pseudo,
      'password': hashSaltPassword
    };
    String requestBodyJson = jsonEncode(requestBody);
    Uri uri = Uri.https('apiuser.fantomgames.eu',
      'addUser');
    http.Response response = await http.post(
      uri,
      body: requestBodyJson,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
    );
    if (response.statusCode != 200) {
      return "error";
    }
    return response.body;
  }catch(e){
    return e.toString();
  }
}

