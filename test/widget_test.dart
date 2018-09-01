import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:boono_mobile/main.dart';
import 'helper/shared_preferences_helper.dart';
import 'helper/sqflite_helper.dart';

void main() async {
  SharedPreferences prefs = await prefsMock();

  sqfliteMock();

  const MethodChannel('plugins.flutter.io/firebase_messaging')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    return null;
  });

  await prefs.setString('themeData', 'dark');

  testWidgets('app test', (WidgetTester tester) async {
    await tester.pumpWidget(App(
      currentTheme: await getCurrentThemeData(),
    ));

    final Finder dynamicTheme = find.byType(DynamicTheme);
    expect(dynamicTheme, findsOneWidget);
  });

  testWidgets('error page test', (WidgetTester tester) async {
    await tester.pumpWidget(new ErrorPage());
  });
}
