import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<List<dynamic>> changePhoneInApi(String pseudo, String phone) async {
  try {
    List<dynamic> result = [];
    Uri uri = Uri.https('apiuser.fantomgames.eu',
        '/changePhone/$pseudo/$phone'
    );
    http.Response response = await http.post(uri,
      headers: <String, String>{
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
    Uri uri = Uri.https('apiuser.fantomgames.eu',
        '/changeFirstName/$pseudo/$firstName'
    );
    http.Response response = await http.post(uri,
      headers: <String, String>{
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
    Uri uri = Uri.https('apiuser.fantomgames.eu',
        '/changeLastName/$pseudo/$lastName'
    );
    http.Response response = await http.post(uri,
      headers: <String, String>{
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


Future<List<dynamic>> changeImageInApi(String pseudo, String image) async {
  try {
    String encodedImage = Uri.encodeComponent(image);
    List<dynamic> result = [];
    Uri uri = Uri.https('apiuser.fantomgames.eu',
        '/changeImage/$pseudo/$encodedImage'
    );
    http.Response response = await http.post(uri,
      headers: <String, String>{
        'Access-Control-Allow-Origin': '*',
      },
    );
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