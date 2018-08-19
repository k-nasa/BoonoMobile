import 'package:flutter_test/flutter_test.dart';
import 'package:boono_mobile/model/sub_item_task.dart';
import 'package:flutter/services.dart';
import '../helper/sqflite_helper.dart';

SubItemTask subItemTask = SubItemTask(
  subId: 12,
  httpMethod: 'get',
  url: 'dummy_url',
);

Map subItemTaskMap = <String, dynamic> {
  'http_method': 'get',
  'url': 'dummy_url',
  'sub_id': 12,
};


void main() {
  group('SubItemTask', () {

    MethodChannel sqfliteChannel = sqfliteMock();

    sqfliteChannel.setMockMethodCallHandler((MethodCall methodCall) async {
      if(methodCall.method == 'query') {
        return [subItemTaskMap];
      }

      return null;
    });

   test('toMap', (){
     expect(subItemTask.toMap(), subItemTaskMap);
   });

   test('fromMap', (){
     expect(SubItemTask.fromMap(subItemTaskMap), subItemTask);
   });

   test('all', () async {
     expect(await SubItemTask.all(), [subItemTask]);
   });

   test('execute', () async{
     SubItemTask.execute();
   });
  });
}