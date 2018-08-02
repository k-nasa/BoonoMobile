import 'package:flutter_test/flutter_test.dart';
import 'package:boono_mobile/model/new_info.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('NewInfo', (){

    const MethodChannel channel = MethodChannel(
      'plugins.flutter.io/shared_preferences',
    );

    final List<MethodCall> log = <MethodCall>[];
    SharedPreferences prefs;

    setUp(() async {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        if (methodCall.method == 'getAll') {
          return <String, dynamic>{};
        }
        return null;
      });
      prefs = await SharedPreferences.getInstance();
      log.clear();
    });

    tearDown((){
      prefs.clear();
    });

    test('updateNewInfo', ()  async {
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

    //test('fetchNewInfo', (){
    //  // TODO ServerMockが必要
    //});
  });
}