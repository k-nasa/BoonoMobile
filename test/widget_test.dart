import 'package:flutter_test/flutter_test.dart';
import 'package:boono_mobile/main.dart' as app;
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'helper/shared_preferences_helper.dart';

void main() async {
  await prefsMock();

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

  testWidgets('app test', (WidgetTester tester) async {
    app.main();
    await tester.pumpWidget(new app.App());
    await tester.pumpWidget(new app.ErrorPage());
  });
}
