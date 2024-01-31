import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<String> changePasswordInApi(String email, String pseudo) async {
  try {
    Map<String, String> requestBody = {
      'email': email,
      'pseudo': pseudo,
    };
    Uri uri = Uri.https('apiuser.fantomgames.eu',
        '/forgotPassword'
    );
    http.Response response = await http.post(
      uri,
      body: requestBody,
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
      },
    );
    if (response.statusCode != 200) {
      return response.statusCode.toString();
    }
    return response.body;
  }catch(e){
    if (kDebugMode) {
      print(e.toString());
    }
    return e.toString();
  }
}

