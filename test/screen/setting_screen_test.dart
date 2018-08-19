import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:boono_mobile/screen/setting_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boono_mobile/screen/styles/mainStyle.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import '../helper/shared_preferences_helper.dart';

void main() {
  testWidgets('setting_screen', (WidgetTester tester) async {
    await tester.pumpWidget(
        DynamicTheme(
            defaultBrightness: Brightness.light,
            data: (_) => themeData,
            themedWidgetBuilder: (BuildContext context, ThemeData theme) {
              return MaterialApp(
                theme: themeData,
                home: Scaffold(body: SettingScreen()),
              );
            }
        )
    );
    SharedPreferences prefs = await prefsMock();

    Finder themeSwitch = find.text('Dark　👻');

    expect(themeSwitch, findsOneWidget);
    await tester.tap(themeSwitch);

    String themeText = await prefs.getString('themeData');
    expect(themeText, 'dark');

    themeSwitch = find.text('Light　🌞');
    expect(themeSwitch, findsOneWidget);
    await tester.tap(themeSwitch);

    themeText = await prefs.getString('themeData');
    expect(themeText, 'light');
  });
}
