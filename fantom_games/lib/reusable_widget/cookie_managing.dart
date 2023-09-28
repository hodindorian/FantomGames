import 'package:shared_preferences/shared_preferences.dart';

void saveCookie(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}


Future<String?> getCookie(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

void deleteCookie(String key) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}
