import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentaroom/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rent A Room',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.barlowTextTheme(Theme.of(context).textTheme,),
      ),
      home: const Splash(),
    );
  }
}
