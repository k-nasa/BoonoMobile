import 'dart:async';

import 'package:flutter/material.dart';
import 'package:boono_mobile/config/conf.dart';
import 'package:boono_mobile/model/sub_item_task.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/new_info.dart';
import 'screen/styles/mainStyle.dart';
import 'screen/widget/concerns/splash_screen.dart';
import 'package:boono_mobile/screen/widget/concerns/bottom_nav_bar.dart';

void main() async {
  final Config config = Config();

  if(await config.init()){
    await NewInfo.fetchNewInfo();
    var currentTheme = await getCurrentThemeData();

    runApp(
        MaterialApp(
          theme: currentTheme,
          home: MySplashScreen(),
        )
    );
  }
  else
    runApp(new ErrorPage());
}

class App extends StatelessWidget {
  const App({this.currentTheme});

  final ThemeData currentTheme;

  @override
  Widget build(BuildContext context) {

    SubItemTask.execute();

    /* FIXME InheritedWidgetが効いてないのかMainBlocProviderを子Widgetから参照できなかったので
     * 今のような外部ライブラリを使う実装になっている
     * MainBlocを使用した形に書き直したい。　今のままだとライブラリ内の無駄が多い
     * https://github.com/Norbert515/dynamic_theme このコードを参考に行けるはず
     */

    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (_) => currentTheme ?? themeData,
        themedWidgetBuilder: (BuildContext context, ThemeData theme){
          return MaterialApp(
            title: 'Boono!',
            theme: theme,
            home: BottomNavigation(),
          );
        }
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

Future<ThemeData> getCurrentThemeData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final String currentThemeString = prefs.getString('themeData');
  if(currentThemeString == null)
    return themeData;

  return currentThemeString == 'dark'? themeDataDark : themeData;
}
