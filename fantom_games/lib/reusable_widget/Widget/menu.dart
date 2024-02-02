import 'package:flutter/material.dart';

import '../../views/home/main_page.dart';
import '../../views/menu/profil.dart';

class ReusableMenu extends StatefulWidget {

  final Color color;

  const ReusableMenu({super.key, required this.color});

  @override
  State<ReusableMenu> createState() => _ReusableMenuState();
}

class _ReusableMenuState extends State<ReusableMenu> with SingleTickerProviderStateMixin{

  late AnimationController controller;
  double height = 0;
  bool menuOpen = false;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return OverflowBox(
      child:
        Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          height == 0 ? height = screenWidth*0.1 : height = 0;
                          if(height == screenWidth*0.1) {
                            menuOpen = true;
                          }else{
                            menuOpen = false;
                          }
                          isPlaying = !isPlaying;
                          isPlaying
                              ? controller.forward()
                              : controller.reverse();
                        });
                      },
                      child: Container(
                        height: screenHeight*0.06,
                        width: screenWidth*0.12,
                        color: widget.color,
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              width: height == screenWidth*0.1 ? screenWidth*0.05 : 0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: screenWidth*0.01),
                              child: Text(
                                height == screenWidth*0.1 ? "Close" : "Menu",
                                style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: screenWidth*0.015),
                              ),
                            ),
                            const Spacer(),
                            Align(
                              child: AnimatedIcon(
                                progress: controller,
                                color: Colors.white,
                                icon: AnimatedIcons.menu_close,
                                size: screenWidth*0.017,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ),
            if(menuOpen)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.06,
                left: MediaQuery.of(context).size.width * 0.02,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1.0, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(controller),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height * 0),
                      TextButton(
                        onPressed:(){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainPage(title: 'Accueil'),
                            ),
                          );
                        },
                        child: const Text(
                          'Accueil',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Profil(),
                            ),
                          );
                        },
                        child: const Text(
                          'Profil',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
    );
  }
}

