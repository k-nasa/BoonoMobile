import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'styles/mainStyle.dart';

class SettingScreen extends StatelessWidget {
  final ValueChanged<ThemeData> onSelectedTheme;

  const SettingScreen({Key key, this.onSelectedTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        ThemeSwitcher(),
      ],
    );
  }
}

class ThemeSwitcher extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);

    return SimpleDialog(
        title: const Text('テーマ選択'),
        children: <Widget>[
          new RadioListTile<Color>(
            value: themeData.primaryColor,
            groupValue: currentTheme.primaryColor,
            onChanged: (value) async {
              setThemeData(themeData, context);
            },
            title: new Text('Light　🌞', style: Theme.of(context).textTheme.display3,),
          ),
          new RadioListTile<Color>(
              value: themeDataDark.primaryColor,
              groupValue: currentTheme.primaryColor,
              onChanged: (value){
                setThemeData(themeDataDark, context);
              },
              title: Text('Dark　👻', style: Theme.of(context).textTheme.display3,)
          ),
        ],
    );
  }

  void setThemeData(ThemeData currentThemeData, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String themeDataString = currentThemeData== themeData ? 'light' : 'dark';

    await prefs.setString('themeData', themeDataString);

    DynamicTheme.of(context).setThemeData(currentThemeData);
  }
}
