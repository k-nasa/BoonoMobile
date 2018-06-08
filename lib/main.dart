import 'package:flutter/material.dart';
import 'package:boono_mobile/config/conf.dart';
import 'package:flutter/rendering.dart';

import 'package:boono_mobile/page/widget/bottom_nav_bar.dart';

var token;

void main() async {
  Config config = new Config();
  await config.init();
  token = config.token;

  print(token);
  if(token != null) {
    print(token);
    runApp(new App());
  }
  else
    runApp(new ErrorPage());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
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
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Center(child: new Text('サーバーとの通信でエラーが起きました'),),
    );
  }

}
