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
      title: 'Boono!',
      theme: themeDate,
      home: new BottomNavigation(),
    );
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Boono',
      theme: ThemeData(primaryColor: Colors.blue),
      home: const Scaffold(
        //TODO 後からちゃんとしたエラーページに差し替える
        // 優先度は結構低い
        body: Center(
          child: Text('初期設定にネットワーク環境が必要です\nネットに繋いだ状態でアプリを再起動してください'),
        ),
      )
    );
  }

}
