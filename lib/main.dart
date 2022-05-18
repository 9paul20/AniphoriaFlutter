import 'package:aniphoria/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Color _primaryColor = HexColor("#363637");
  Color _accentColor = HexColor("#FF1166");

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AniPhoria',
      theme: ThemeData(
        primaryColor: _primaryColor,
        accentColor: _accentColor,
      ),
      home: SplashScreen(
          title: 'AniPhoria',
      ),
    );
  }
}
