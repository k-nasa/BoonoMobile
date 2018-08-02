import 'dart:async';

import 'package:flutter/material.dart';
import 'package:boono_mobile/config/conf.dart';
import 'package:boono_mobile/model/sub_item_task.dart';
import 'package:boono_mobile/screen/widget/concerns/bottom_nav_bar.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/new_info.dart';
import 'screen/styles/mainStyle.dart';

void main() async {
  final Config config = new Config();

  if(await config.init()){
    await NewInfo.fetchNewInfo();

    runApp(new App(currentTheme: await getCurrentThemeData()));
  }
  else
    runApp(new ErrorPage());
}

class App extends StatelessWidget {
  App({this.currentTheme});

  ThemeData currentTheme;

  @override
  Widget build(BuildContext context) {

    SubItemTask.execute();

    return new DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (_) => currentTheme ?? themeData,
        themedWidgetBuilder: (BuildContext context, ThemeData theme){
          return new MaterialApp(
            title: 'Boono!',
            theme: theme,
            home: BottomNavigation(),
          );
        }
    );
  }
}

Future<ThemeData> getCurrentThemeData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final String currentThemeString = prefs.getString('themeData');
  if(currentThemeString == null)
    return themeData;

  return currentThemeString == 'dark'? themeDataDark : themeData;
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
