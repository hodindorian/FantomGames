import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<String> disconnectInApi(String pseudo) async {
  try {
    Map<String, String> requestBody = {
      'pseudo': pseudo,
    };
    String requestBodyJson = jsonEncode(requestBody);
    Uri uri = Uri.https('apiuser.fantomgames.eu',
        'disconnected'
    );
    http.Response response = await http.post(
      uri,
      body: requestBodyJson,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
    );
    String res = response.body.replaceAll(' ', '');
    if (response.statusCode != 200 || res == "error") {
      return "error";
    }else if (res == "notWorking"){
      return "unexpected error, aled";
    }else if (res == "OK"){
      return "";
    }else {
      return "no case";
    }
  }catch(e){
    return e.toString();
  }
}

