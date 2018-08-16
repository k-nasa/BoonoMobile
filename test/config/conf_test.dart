import 'package:flutter_test/flutter_test.dart';
import 'package:boono_mobile/config/conf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import '../helper/shared_preferences_helper.dart';

void main() {
  group('Config', (){
    SharedPreferences prefs;
    Config config;

    const MethodChannel channel = MethodChannel('plugins.flutter.io/path_provider');
    String response = '/dummy/path';

    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return response;
    });

    const MethodChannel('com.tekartik.sqflite')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'openDatabase') {
        Database db;
        return db;
      }
      return null;
    });

    setUp(() async {
      prefs = await prefsMock();
      config = Config();
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