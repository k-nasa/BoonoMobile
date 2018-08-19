import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boono_mobile/screen/styles/mainStyle.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:boono_mobile/main.dart' as app;
import 'package:boono_mobile/main.dart';
import 'helper/shared_preferences_helper.dart';


void main() async {
  SharedPreferences prefs = await prefsMock();

  const MethodChannel('plugins.flutter.io/path_provider').setMockMethodCallHandler((MethodCall methodCall) async {
    return '/dummy/path';
  });

  const MethodChannel('com.tekartik.sqflite').setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'openDatabase') {
      Database db;
      return db;
    }
    return null;
  });


  const MethodChannel('plugins.flutter.io/firebase_messaging').setMockMethodCallHandler((MethodCall methodCall) async {
    return null;
  });

  await prefs.setString('themeData', 'dark');

  testWidgets('app test', (WidgetTester tester) async {
    await tester.pumpWidget(App(currentTheme: themeData,));

    final Finder dynamicTheme = find.byType(DynamicTheme);
    expect(dynamicTheme, findsOneWidget);
  });

  testWidgets('error page test', (WidgetTester tester) async {
    await tester.pumpWidget(new ErrorPage());
  });
}
