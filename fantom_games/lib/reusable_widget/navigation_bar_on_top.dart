import 'package:flutter/material.dart';

class NavigationBarOnTop extends StatelessWidget {
  final String title;

  const NavigationBarOnTop({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Positioned(
      top: screenHeight * 0,
      left: screenWidth * 0,
      child: Container(
        width: screenWidth,
        height: screenHeight * 0.06,
        color: const Color(0xFF003366),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.03,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

