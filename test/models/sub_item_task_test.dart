import 'package:flutter_test/flutter_test.dart';
import 'package:boono_mobile/model/sub_item_task.dart';

void main() {
  group('SubItemTask', () {
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

   test('toMap', (){
     expect(subItemTask.toMap(), subItemTaskMap);
   });

   test('fromMap', (){
     expect(SubItemTask.fromMap(subItemTaskMap) == subItemTask , isTrue);
   });
  });
}