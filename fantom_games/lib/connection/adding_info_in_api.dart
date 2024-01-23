import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<String> changePhoneInApi(String pseudo, String phone) async {
  try {
    Uri uri = Uri.https('apiuser.fantomgames.eu',
        '/changePhone/$pseudo/$phone'
    );
    http.Response response = await http.post(uri,
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

Future<String> changeMailInApi(String pseudo, String phone) async {
  try {
    Uri uri = Uri.https('apiuser.fantomgames.eu',
        '/changePhone/$pseudo/$phone'
    );
    http.Response response = await http.post(uri,
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