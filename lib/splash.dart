import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:rentaroom/rooms.dart';

class Splash extends StatefulWidget {
  const Splash({ Key? key }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late double scrHeight, scrWidth, resWidth;

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Get.off(() => const Rooms())
    );
  }
  @override
  Widget build(BuildContext context) {
    scrHeight = MediaQuery.of(context).size.height;
    scrWidth = MediaQuery.of(context).size.width;

    if (scrWidth <= 600) {
      resWidth = scrWidth;
    } else {
      resWidth = scrWidth * 0.75;
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFFBBDEFB), Color(0xFF3949AB)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropShadowImage(
                  image: Image.asset('assets/img/splash_logo.png', scale: 3),
                  borderRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(3, 3),
                  scale: 1,
                ),
                Text(
                  "Rent A Room",
                  style: TextStyle(
                    fontSize: resWidth * 0.1,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                JumpingDotsProgressIndicator(
                  fontSize: resWidth * 0.1, 
                  color: Colors.white
                ),
                Text(
                  "Version 1.0",
                  style: TextStyle(
                    fontSize: resWidth * 0.05,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}