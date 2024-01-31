 import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:fantom_games/model/global_object.dart';
import 'package:fantom_games/reusable_widget/session_managing.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:provider/provider.dart';

Future<List<dynamic>> connectingUserToApi(String pseudo, String password, bool stayConnected, BuildContext context) async {
  List<dynamic> result = [];
  late Map<String, String> requestBody;
  try {
    String sha256Password = sha256.convert(utf8.encode(password)).toString();
    String idComputer = (Random().nextInt(900000) + 100000).toString();
    if(stayConnected){
      requestBody = {
        'pseudo': pseudo,
        'password': sha256Password,
        'idComputer': idComputer,
      };
    }else{
      requestBody = {
        'pseudo': pseudo,
        'password': sha256Password,
        'idComputer': 'none',
      };
    }
    Uri uri = Uri.https('apiuser.fantomgames.eu',
        '/userConnection',
        requestBody
    );
    http.Response response = await http.get(
      uri,
      headers: {
        'Access-Control-Allow-Origin':'*'
      }
    );
    try {
      if(response.statusCode != 200){
        result.add("error");
        result.add(response.toString());
        return result;
      }
      var rep = jsonDecode(response.body);
      rep=rep[0];
      if (rep == "no user") {
        result.add("no user");
        return result;
      } else if (rep == "wrong password") {
        result.add("wrong_password");
        return result;
      } else if (rep == "already connected") {
        result.add("already connected");
        return result;
      } else if (rep['pseudo'] == pseudo) {
        if (stayConnected){
          if(context.mounted){
            var globalObject = Provider.of<GlobalObject>(context, listen: false);
            globalObject.stayConnected = true;
          }
          setSession("id", rep['id']);
          setSession("pseudo", pseudo);
          setSession("idComputer",idComputer);
        }
        result.add("OK");
        result.add(rep['email']);
        result.add(rep['pseudo']);
        result.add(rep['lastname']);
        result.add(rep['firstname']);
        result.add(rep['phoneNumber']);
        result.add(rep['gameLevel']);
        result.add(rep['cryptoBalance']);
        result.add(rep['image']);
        return result;
      } else{
        result.add("error unknown");
        return result;
      }
    } on Error catch (e) {
      result.add(e.toString());
      return result;
    }
  }catch(e) {
    result.add(e.toString());
    return result;
  }
}

