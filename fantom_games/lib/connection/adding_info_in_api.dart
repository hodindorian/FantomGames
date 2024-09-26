import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:async';
import 'package:image/image.dart' as img;


Future <List<dynamic>> gettingInfo(Response response, String pseudo) async{
  try {
    List<dynamic> result = [];
    if (response.statusCode != 200) {
      result.add(response.statusCode.toString());
      return result;
    }
    var rep = jsonDecode(response.body);
    rep = rep[0];
    if (rep.length == 0) {
      result.add('Unexpected error');
      return result;
    } else if (rep['pseudo'] == pseudo) {
      result.add(true);
      result.add(rep['email']);
      result.add(rep['pseudo']);
      result.add(rep['lastname']);
      result.add(rep['firstname']);
      result.add(rep['phoneNumber']);
      result.add(rep['gameLevel']);
      result.add(rep['cryptoBalance']);
      return result;
    } else {
      result.add('Unexpected error');
      return result;
    }
  }catch(e){
    if (kDebugMode) {
      print(e.toString());
    }
    List<dynamic> result = [];
    result.add(e.toString());
    return result;
  }
}

Future<Response> addingInfo(Uri uri, String requestBodyJson) async{
  try {
    http.Response response = await http.post(
      uri,
      body: requestBodyJson,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
    );
    return response;
  }catch(e){
    if (kDebugMode) {
      print(e.toString());
    }
    return Response('Unexpected Error', 400);
  }
}

Future<List<dynamic>> changePhoneInApi(String pseudo, String phone) async {
  Map<String, String> requestBody = {
    'pseudo': pseudo,
    'phone': phone,
  };
  String requestBodyJson = jsonEncode(requestBody);
  Uri uri = Uri.https('apiuser.hodindorian.com', '/changePhone');

  Response response = await addingInfo(uri, requestBodyJson);
  List<dynamic> result = await gettingInfo(response, pseudo);

  return result;
}

Future<List<dynamic>> changeFirstNameInApi(String pseudo, String firstName) async {
  Map<String, String> requestBody = {
    'pseudo': pseudo,
    'firstName': firstName,
  };
  String requestBodyJson = jsonEncode(requestBody);
  Uri uri = Uri.https('apiuser.hodindorian.com', '/changeFirstName');

  Response response = await addingInfo(uri, requestBodyJson);
  List<dynamic> result = await gettingInfo(response, pseudo);

  return result;
}

Future<List<dynamic>> changeLastNameInApi(String pseudo, String lastName) async {
  Map<String, String> requestBody = {
    'pseudo': pseudo,
    'lastName': lastName,
  };
  String requestBodyJson = jsonEncode(requestBody);
  Uri uri = Uri.https('apiuser.hodindorian.com',
      '/changeLastName'
  );

  Response response = await addingInfo(uri, requestBodyJson);
  List<dynamic> result = await gettingInfo(response, pseudo);

  return result;

}

Future<List<dynamic>> changeImageInApi(String pseudo, Uint8List imageUint) async {
  img.Image? image = img.decodeImage(imageUint);

  if (image!.lengthInBytes > 2 * 1024 * 1024) {
    image = img.copyResize(image, width: 800);
  }
  String imageBase64 = base64Encode(img.encodeJpg(image));

  Uri uri = Uri.https('apiuser.hodindorian.com', '/changeImage');
  var request = http.MultipartRequest('POST', uri)
    ..fields['pseudo'] = pseudo
    ..files.add(http.MultipartFile.fromBytes(
      'image',
      base64Decode(imageBase64),
      filename: 'image.jpg',
    ));

  request.headers['Access-Control-Allow-Origin'] = '*';
  http.Response response = await http.Response.fromStream(await request.send());

  List<dynamic> result = await gettingInfo(response, pseudo);

  return result;
}
