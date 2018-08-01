import 'package:flutter/material.dart';

final themeDate = new ThemeData(
  primarySwatch: Colors.teal,
  primaryColor: Colors.teal,
  backgroundColor: Colors.brown[50],
  // MEMO 定義されている用途ではないけどいいのか？
  secondaryHeaderColor: Colors.white,
  accentColor: Colors.orangeAccent,
  fontFamily: 'Raleway',
  textTheme: const TextTheme(
    body1: TextStyle(color: CustomColors.textColor),
    body2: TextStyle(color: CustomColors.textColor),
    display1: TextStyle(color: CustomColors.textColor),
    display2: TextStyle(color: CustomColors.textColor),
    display3: TextStyle(color: CustomColors.textColor),
    // ちょっとした見出しに使う
    display4: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 15.0),
    caption: TextStyle(color: CustomColors.textColor),
    subhead: TextStyle(color: CustomColors.textColor),
    headline: TextStyle(color: CustomColors.textColor),
    title: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: CustomColors.textColor),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: CustomColors.textColor,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  ),
);

class CustomColors{
  static const Map<int, Color> theme = const <int, Color>{
    100: Color(0xFF3C4A60),
  };

  static const textColor = Color(0xFF3C4A60);
}
