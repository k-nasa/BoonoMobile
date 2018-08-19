import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:boono_mobile/model/subscription_item.dart';
import '../helper/sqflite_helper.dart';

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
    MethodChannel sqflite = sqfliteMock();

    sqflite.setMockMethodCallHandler((MethodCall methodCall) async {
      if(methodCall.method == 'query') {
        return [subItemMap];
      }
      return null;
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
