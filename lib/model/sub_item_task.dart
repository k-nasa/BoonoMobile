import 'dart:async';
import 'package:boono_mobile/config/db_manager.dart';
import 'package:boono_mobile/model/subscription_item.dart';
import 'package:http/http.dart' as http;

class SubItemTask {
  String httpMethod;
  String url;
  int subId;

  SubItemTask({this.httpMethod, this.url, this.subId});

  SubItemTask.fromMap(Map map) {
    subId = map['sub_id'];
    httpMethod = map['http_method'];
    url = map['url'];
  }

  static const String TABLE_NAME = 'subscription_item_tasks';

  void save() async {
    final db = new DBManager();
    await db.openDB();

    await db.database.insert(TABLE_NAME, toMap());
  }

  static void execute() async {
    List<SubItemTask> tasks = await all();
    if (tasks == null) return;

    for (SubItemTask task in tasks) {
      if (await task.exe()) {
        await task.delete();
      }
    }
  }

  Future<bool> exe() async {
    try {
      final res = await gHttpRequest();

      if (res.statusCode == 200 || res.body.hashCode == 144165402)
        return true;
      else
        return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> delete() async {
    DBManager db = new DBManager();
    await db.openDB();

    await db.database
        .delete(TABLE_NAME, where: 'sub_id= ?', whereArgs: <int>[subId]);
    print('タスク完了しました');
  }

  static Future<List<SubItemTask>> all() async {
    DBManager db = new DBManager();
    await db.openDB();

    final List<Map> maps =
        await db.database.rawQuery('select * from $TABLE_NAME');

    List<SubItemTask> tasks = [];

    for (var task in maps ?? <List>[]) tasks.add(SubItemTask.fromMap(task));

    return tasks;
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'http_method': httpMethod,
        'url': url,
        'sub_id': subId,
      };

  Future<http.Response> gHttpRequest() async {
    final db = new DBManager();
    String userToken = await db.fetchUserToken();

    switch (httpMethod) {
      case 'post':
        SubscriptionItem subItem = await SubscriptionItem.find(subId);

        Map requestBody = <String, dynamic>{'token': userToken}
          ..addAll(subItem.toMap())
          ..remove('id')
          ..addAll(<String, dynamic>{'sub_id': subId.toString()});

        return http.post(url, body: requestBody);
      case 'delete':
        return http.delete('$url/$userToken/${subId.toString()}');
      default:
        return http.get(url);
    }
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    return other is SubItemTask &&
        other.httpMethod == httpMethod &&
        other.subId == subId &&
        other.url == url;
  }
}
