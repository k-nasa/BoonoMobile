import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:boono_mobile/model/subscription_item.dart';

SubscriptionItem subscriptionItem = SubscriptionItem(
  id: 12,
  type: 'TitleItem',
  content: '約束のネバーランド',
);

Map subItemMap = <String, dynamic> {
  'id': 12,
  'type': 'TitleItem',
  'content': '約束のネバーランド',
};


void main() {
  group('SubItemTask', () {
    const MethodChannel('com.tekartik.sqflite').setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'openDatabase') {
        Database db;
        return db;
      }
      if(methodCall.method == 'query') {
        return [subItemMap];
      }

      return null;
    });

    const MethodChannel('plugins.flutter.io/path_provider').setMockMethodCallHandler((MethodCall methodCall) async {
      return '/dummy/path';
    });

    test('toMap', (){
      expect(subscriptionItem.toMap(), subItemMap);
    });

    test('fromMap', (){
      expect(SubscriptionItem.fromMap(subItemMap), subscriptionItem);
    });

    test('all', () async {
      expect(await SubscriptionItem.all(), [subscriptionItem]);
    });

    test('find', () async {
      expect(await SubscriptionItem.find(12), subscriptionItem);
    });
  });
}
