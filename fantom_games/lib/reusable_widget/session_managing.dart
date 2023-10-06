import 'package:flutter_session_manager/flutter_session_manager.dart';

void setSession(String key, String value) async {
  await SessionManager().set(key, value);
}

void destroySession() async {
  await SessionManager().destroy();
}

void destroyItemSession(String key) async {
  await SessionManager().remove("id");
}

Future<bool> checkItemSession(String key) async {
  return await SessionManager().containsKey("id");
}

Future<dynamic> getItemSession(String key) async {
  return await SessionManager().get(key);
}