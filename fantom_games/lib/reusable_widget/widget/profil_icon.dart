import 'dart:typed_data';
import 'package:flutter/material.dart';

import '../../views/menu/profil.dart';

class ProfilIcon extends StatelessWidget {
  final Uint8List? userImage;
  final String pseudo;

  const ProfilIcon({super.key, required this.pseudo, required this.userImage});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
        top: screenWidth * 0,
        right: screenHeight * 0.01,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Profil()),
            );
          },
          child: Positioned(
            child: Row(
              children: [
                Text(
                  pseudo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: screenHeight * 0.06,
                  height: screenHeight * 0.06,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: ClipOval(
                    child: SizedBox(
                      width: screenHeight * 0.06,
                      height: screenHeight * 0.06,
                      child: userImage!=null
                          ? Image.memory(userImage!, fit: BoxFit.cover)
                          : const CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

