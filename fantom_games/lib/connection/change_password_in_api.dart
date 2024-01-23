import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<String> changePasswordInApi(String email, String pseudo) async {
  try {
    String encodedMail = email.replaceAll('.', '\$&\$');
    Uri uri = Uri.https('apiuser.fantomgames.eu',
        '/forgotPassword/$encodedMail/$pseudo'
    );
    http.Response response = await http.post(uri);
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

