import 'package:flutter/material.dart';
import 'package:boono_mobile/config/conf.dart';

import 'package:boono_mobile/page/widget/bottom_nav_bar.dart';

var token;

void main() async {
  Config config = new Config();
  await config.init();
  token = config.token;

  runApp(new App());
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
