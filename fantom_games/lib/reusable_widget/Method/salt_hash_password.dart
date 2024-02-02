import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';


String hashPassword(String password) {
  final salt = _generateSalt();
  final sha256Password = sha256.convert(utf8.encode(password)).toString();
  final saltedPassword = utf8.encode(sha256Password + salt);
  final hash = sha256.convert(saltedPassword).toString();
  final saltedHashedPassword = '$salt\$$hash';
  return saltedHashedPassword;
}

String _generateSalt() {
  final random = Random.secure();
  final saltBytes = List<int>.generate(16, (i) => random.nextInt(256));
  final salt = base64Url.encode(saltBytes);
  return salt;
}