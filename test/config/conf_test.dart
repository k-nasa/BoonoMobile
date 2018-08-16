import 'package:flutter_test/flutter_test.dart';
import 'package:boono_mobile/config/conf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import '../helper/shared_preferences_helper.dart';

void main() {
  group('Config', (){
    SharedPreferences prefs;
    Config config = Config();

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

    setUp(() async {
      prefs = await prefsMock();
    });

    tearDown((){
      prefs.clear();
    });

    group('init',() {
      test('prefsに初期データが有る時cleaする', () async {
        prefs.setBool('hoge', false);
        expect(await prefs.getBool('hoge'), false);

        await config.init();
        expect(await prefs.getBool('hoge'), null);
      });
    });
  });
}