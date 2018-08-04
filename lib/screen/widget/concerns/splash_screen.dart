import 'dart:async';
import 'package:flutter/material.dart';
import 'package:boono_mobile/main.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => new _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();

    // TODO 2秒固定でなく初期設定が終わったかどうかでScreenを切り替えるように変更すべき
    // 結構めんどくさそうなので後で
    Timer(Duration(seconds: 2), () async {
      ThemeData currentTheme = await getCurrentThemeData();

      runApp(App(currentTheme: currentTheme));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body:
      Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
