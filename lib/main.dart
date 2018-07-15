import 'package:flutter/material.dart';
import 'package:boono_mobile/config/conf.dart';
import 'package:boono_mobile/model/sub_item_task.dart';
import 'package:boono_mobile/screen/widget/concerns/bottom_nav_bar.dart';

import 'screen/styles/mainStyle.dart';
import 'model/new_info.dart';

void main() async {
  Config config = new Config();

  if(await config.init()){
    await NewInfo.fetchNewInfo();

    runApp(new App());
  }
  else
    runApp(new ErrorPage());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SubItemTask.execute();

    return new MaterialApp(
      title: 'Flutter Demo',
      theme: themeDate,
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
      home: Scaffold(
        body: new Center(
          child: Text('エラーが出ています。アプリを再起動してから開いてみてください'),
        ),
      )
    );
  }

}
