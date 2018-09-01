import 'package:flutter_test/flutter_test.dart';
import 'package:boono_mobile/model/new_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/shared_preferences_helper.dart';
import '../helper/sqflite_helper.dart';

void main() {
  group('NewInfo', () {
    SharedPreferences prefs;
    sqfliteMock();

    setUp(() async {
      prefs = await prefsMock();
    });

    tearDown(() {
      prefs.clear();
    });

    test('updateNewInfo', () async {
      bool beforeValue = prefs.getBool('new_info');

      expect(beforeValue, null);

      await NewInfo.updateNewInfo(false);
      bool afterValue = prefs.getBool('new_info');
      expect(afterValue, false);
    });

    test('newInfo', () async {
      bool beforeValue = prefs.getBool('new_info');

      expect(beforeValue, null);

      // nullのときはtrueを返す
      expect(await NewInfo.newInfo(), true);

      prefs.setBool('new_info', false);
      expect(await NewInfo.newInfo(), false);
    });

    test('fetchNewInfo', () async {
      expect(await prefs.getBool('new_info'), isNull);

      await NewInfo.fetchNewInfo();
      expect(await prefs.getBool('new_info'), isNotNull);
    });
  });
}
