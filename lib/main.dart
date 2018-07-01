import 'package:flutter/material.dart';
import 'package:boono_mobile/config/conf.dart';

import 'package:boono_mobile/screen/widget/bottom_nav_bar.dart';

String token;

void main() async {
  Config config = new Config();

  if(await config.init())
    runApp(new App());
  else
    runApp(new ErrorPage());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.orange,
        backgroundColor: Colors.grey[1000]
      ),
      home: new BottomNavigation(),
    );
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.blue),
      home: new Center(
        child: Text('エラーが出ています。アプリを再起動してから開いてみてください'),
      )
    );
  }

}
