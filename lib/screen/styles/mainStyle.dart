import 'package:flutter/material.dart';

// MEMO ものと用途として使用していないプロパティが多いと思う
// 自分で定義してしまって各Widgetでいい感じに適用するやり方が無難な気がする
final themeData = new ThemeData(
  // 画像がないときの背景色として使われている
  primarySwatch: Colors.teal,

  // HeaderとFooterの色
  primaryColor: Colors.teal,
  canvasColor: Colors.teal,
  backgroundColor: Colors.brown[50],

  // MEMO 定義されている用途ではないけどいいのか？
  // CardなどのBackgroundColor用途で使用
  secondaryHeaderColor: Colors.white,
  accentColor: Colors.orangeAccent,
  fontFamily: 'Raleway',
  dialogBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    body1: TextStyle(color: CustomColors.textColor),
    body2: TextStyle(color: CustomColors.textColor),
    display1: TextStyle(color: CustomColors.textColor),
    display2: TextStyle(color: CustomColors.textColor),
    display3: TextStyle(color: CustomColors.textColor, fontSize: 18.0),

    // ちょっとした見出しに使う
    display4: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 20.0),

    caption: TextStyle(color: CustomColors.textColor),
    subhead: TextStyle(color: CustomColors.textColor),
    headline: TextStyle(color: CustomColors.textColor),
    title: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: CustomColors.textColor),
  ),

  accentIconTheme: const IconThemeData(
      color: Colors.blueAccent,
  ),

  inputDecorationTheme: const InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    hintStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: CustomColors.textColor,
    ),
  ),
);

// ダークモード用のThemeData
final themeDataDark = new ThemeData(
  // 画像がないときの背景色として使われている
  primarySwatch: Colors.grey,

  // HeaderとFooterの色
  primaryColor: const Color.fromRGBO(58, 66, 86, 1.0),
  backgroundColor: const Color.fromRGBO(38, 46, 66, 1.0),

  canvasColor: const Color.fromRGBO(58, 66, 86, 1.0),

  // MEMO 定義されている用途ではないけどいいのか？
  // CardなどのBackgroundColor用途で使用
  secondaryHeaderColor: const Color.fromRGBO(64, 75, 96, 0.8),
  accentColor: Colors.orangeAccent,
  dialogBackgroundColor: const Color.fromRGBO(64, 75, 96, 0.8),
  fontFamily: 'Raleway',
  textTheme: const TextTheme(
    body1: TextStyle(color: CustomColors.textColorDark),
    body2: TextStyle(color: CustomColors.textColorDark),
    display1: TextStyle(color: CustomColors.textColorDark),
    display2: TextStyle(color: CustomColors.textColorDark),
    display3: TextStyle(color: CustomColors.textColorDark, fontSize: 18.0),

    // ちょっとした見出しに使う
    display4: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0),

    caption: TextStyle(color: CustomColors.textColorDark),
    subhead: TextStyle(color: Colors.white),
    headline: TextStyle(color: Colors.white),
    title: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
  ),

  accentIconTheme: const IconThemeData(
      color: Colors.cyanAccent,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: const Color.fromRGBO(64, 75, 96, 0.9),
    filled: true,
    hintStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: CustomColors.textColorDark,
    ),
  ),
);
class CustomColors{
  static const Map<int, Color> theme = const <int, Color>{
    100: Color(0xFF3C4A60),
  };

  static const textColor = Color(0xFF3C4A60);
  static const textColorDark = Colors.white70;
}
