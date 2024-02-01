import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<List<dynamic>> changePhoneInApi(String pseudo, String phone) async {
  try {
    List<dynamic> result = [];
    Map<String, String> requestBody = {
      'pseudo': pseudo,
      'phone': phone,
    };
    String requestBodyJson = jsonEncode(requestBody);
    Uri uri = Uri.https('apiuser.fantomgames.eu',
        '/changePhone'
    );
    http.Response response = await http.post(
      uri,
      body: requestBodyJson,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
    );
    if (response.statusCode != 200) {
      result.add(response.statusCode.toString());
      return result;
    }
    var rep = jsonDecode(response.body);
    rep=rep[0];
    if(rep.length == 0){
      result.add('Unexpected error');
      return result;
    }else if (rep['pseudo'] == pseudo) {
      result.add(true);
      result.add(rep['email']);
      result.add(rep['pseudo']);
      result.add(rep['lastname']);
      result.add(rep['firstname']);
      result.add(rep['phoneNumber']);
      result.add(rep['gameLevel']);
      result.add(rep['cryptoBalance']);
      result.add(rep['image']);
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

Future<List<dynamic>> changeFirstNameInApi(String pseudo, String firstName) async {
  try {
    List<dynamic> result = [];
    Map<String, String> requestBody = {
      'pseudo': pseudo,
      'firstName': firstName,
    };
    String requestBodyJson = jsonEncode(requestBody);
    Uri uri = Uri.https('apiuser.fantomgames.eu',
        '/changeFirstName'
    );
    http.Response response = await http.post(
      uri,
      body: requestBodyJson,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
    );
    if (response.statusCode != 200) {
      result.add(response.statusCode.toString());
      return result;
    }
    var rep = jsonDecode(response.body);
    rep=rep[0];
    if(rep.length == 0){
      result.add('Unexpected error');
      return result;
    }else if (rep['pseudo'] == pseudo) {
      result.add(true);
      result.add(rep['email']);
      result.add(rep['pseudo']);
      result.add(rep['lastname']);
      result.add(rep['firstname']);
      result.add(rep['phoneNumber']);
      result.add(rep['gameLevel']);
      result.add(rep['cryptoBalance']);
      result.add(rep['image']);
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

Future<List<dynamic>> changeLastNameInApi(String pseudo, String lastName) async {
  try {
    List<dynamic> result = [];
    Map<String, String> requestBody = {
      'pseudo': pseudo,
      'lastName': lastName,
    };
    String requestBodyJson = jsonEncode(requestBody);
    Uri uri = Uri.https('apiuser.fantomgames.eu',
        '/changeLastName'
    );
    http.Response response = await http.post(
      uri,
      body: requestBodyJson,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
    );
    if (response.statusCode != 200) {
      result.add(response.statusCode.toString());
      return result;
    }
    var rep = jsonDecode(response.body);
    rep=rep[0];
    if(rep.length == 0){
      result.add('Unexpected error');
      return result;
    }else if (rep['pseudo'] == pseudo) {
      result.add(true);
      result.add(rep['email']);
      result.add(rep['pseudo']);
      result.add(rep['lastname']);
      result.add(rep['firstname']);
      result.add(rep['phoneNumber']);
      result.add(rep['gameLevel']);
      result.add(rep['cryptoBalance']);
      result.add(rep['image']);
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


Future<List<dynamic>> changeImageInApi(String pseudo, Uint8List imageUint) async {
  try {
    String image = base64Encode(imageUint);
    List<dynamic> result = [];
    Uri uri = Uri.https('apiuser.fantomgames.eu',
        '/changeImage'
    );
    var request = http.MultipartRequest('POST', uri)
      ..fields['pseudo'] = pseudo
      ..files.add(http.MultipartFile.fromBytes(
        'image',
        base64Decode(image),
        filename: 'image.jpg',
      ));
    request.headers['Access-Control-Allow-Origin'] = '*';
    http.Response response = await http.Response.fromStream(await request.send());
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
      result.add(rep['image']);
      return result;
    } else {
      result.add('Unexpected error');
      return result;
    }
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
    List<dynamic> result = [];
    result.add(e.toString());
    return result;
  }
}