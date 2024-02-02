import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<Uint8List?> getImageInApi(String pseudo) async {
  Uri uri = Uri.https('apiuser.fantomgames.eu',
      '/getImage/$pseudo'
  );
  http.Response response = await http.get(
    uri,
    headers: <String, String>{
      'Access-Control-Allow-Origin': '*',
    },
  );
  Uint8List result = response.bodyBytes.sublist(2);
  if(result.isEmpty){
    return null;
  }
  return result;
}