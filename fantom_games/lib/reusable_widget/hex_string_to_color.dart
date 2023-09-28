import 'package:flutter/material.dart';

Color hexStringToColor(String hexString) {
  final int value = int.parse(hexString, radix: 16);
  return Color(value).withOpacity(1.0);
}