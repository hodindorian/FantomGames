import 'package:flutter/material.dart';

Widget usableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller, bool isReadOnly, Color fieldColor, double width, double height) {
  return SizedBox(
    width: width,
    height: height,
    child: TextField(
      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      readOnly: isReadOnly,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white.withOpacity(0.9)),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white70,
        ),
        labelText: text,
        labelStyle: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: height*0.3
        ),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: fieldColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(width: 2, color: Colors.black),
        ),
      ),
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    ),
  );
}