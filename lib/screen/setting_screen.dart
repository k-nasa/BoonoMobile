import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'styles/mainStyle.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new Column(
        children: <Widget>[
          const Text('テーマ選択'),
          new RadioListTile<ThemeData>(
            value: themeData,
            onChanged: (value){
              DynamicTheme.of(context).setThemeData(value);
            },
            title: new Text("Light"),
          ),
          new RadioListTile<ThemeData>(
              value: themeDataDark,
              onChanged: (value){
                DynamicTheme.of(context).setThemeData(value);
              },
              title: new Text("Spooky  👻")
          ),
        ]
    );
  }
}

