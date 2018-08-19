import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:boono_mobile/model/sub_item_task.dart';
import 'package:flutter/services.dart';

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
    const MethodChannel('com.tekartik.sqflite').setMockMethodCallHandler((MethodCall methodCall) async {
      print(methodCall.method);
      if (methodCall.method == 'openDatabase') {
        Database db;
        return db;
      }
      if(methodCall.method == 'query') {
        return [subItemTaskMap];
      }

      return null;
    });

    const MethodChannel('plugins.flutter.io/path_provider').setMockMethodCallHandler((MethodCall methodCall) async {
      return '/dummy/path';
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