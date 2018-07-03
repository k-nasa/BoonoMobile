import 'package:flutter/material.dart';

final themeDate = new ThemeData(
    primarySwatch: Colors.teal,
    secondaryHeaderColor: Colors.blueGrey,
    backgroundColor: Colors.brown[50],
    accentColor: Colors.orangeAccent,
    fontFamily: 'Raleway',
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.grey,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  ),
);

class CustomColors{
  static const Map<int, Color> theme = const <int, Color>{
    100: Color(0xe),
  };
}
