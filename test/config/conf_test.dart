import 'package:flutter_test/flutter_test.dart';
import 'package:boono_mobile/config/conf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import '../helper/shared_preferences_helper.dart';
import '../helper/sqflite_helper.dart';

void main() {
  group('Config', () {
    SharedPreferences prefs;
    Config config = Config();

    sqfliteMock();

    const MethodChannel('plugins.flutter.io/firebase_messaging')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      return null;
    });

    setUp(() async {
      prefs = await prefsMock();
    });

    tearDown(() {
      prefs.clear();
    });

    group('init', () {
      test('prefsに初期データが有る時cleaする', () async {
        prefs.setBool('hoge', false);
        expect(await prefs.getBool('hoge'), isFalse);

        await config.init();
        expect(await prefs.getBool('hoge'), isNull);
      });

      test('user tokenがセットされる', () async {
        expect(await config.isTokenSetting(), isFalse);

        await config.init();
        //expect(await config.isTokenSetting(), isTrue);
      });
    });
  });
}
