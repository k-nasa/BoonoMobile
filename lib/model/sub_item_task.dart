import 'package:boono_mobile/config/db_manager.dart';
import 'package:boono_mobile/model/subscription_item.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class SubItemTask {
  String http_method;
  String url;
  int sub_id;

  SubItemTask({this.http_method, this.url, this.sub_id});

  static const String TABLE_NAME = 'subscription_item_tasks';

  void save() async {
    final db = new DBManager();
    await db.openDB();

    await db.database.insert(TABLE_NAME, _toMap());
    print('作成しました！！');
  }

  static void execute() async {
    List<SubItemTask> tasks = await all();
    if(tasks == null) return;

    for(SubItemTask task in tasks){
      if(await task.exe()){
        await task.delete();
      }
    }
  }

  Future<bool> exe() async {
    try {
      final res = await g_http_request();
      print(res.body);

      if (res.statusCode == 200)
        return true;
      else
        return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void delete() async {
    DBManager db = new DBManager();
    await db.openDB();

    await db.database.delete(TABLE_NAME, where: 'sub_id= ?', whereArgs: <int>[sub_id]);
    print('タスク完了しました');
  }

  static Future<List<SubItemTask>> all() async{
    DBManager db = new DBManager();
    await db.openDB();

    final List<Map> maps =  await db.database.rawQuery("select * from $TABLE_NAME");
    if (maps.isEmpty) return null;
    List<SubItemTask> tasks = [];

    for(var task in maps)
      tasks.add(SubItemTask.fromMap(task));

    return tasks;
  }

  Map<String, dynamic> _toMap() =>
      <String, dynamic> {
        'http_method': http_method,
        'url': url,
        'sub_id': sub_id,
      };

  SubItemTask.fromMap(Map map) {
    sub_id = map['sub_id'];
    http_method = map['http_method'];
    url = map['url'];
  }

  Future<http.Response> g_http_request() async {
    final db = new DBManager();
    String userToken = await db.fetchUserToken();

    switch(http_method){
      case 'post':
        SubscriptionItem subItem = await SubscriptionItem.find(sub_id);

        Map request_body = <String,dynamic>{ 'token': userToken }
        ..addAll(subItem.toMap())
        ..addAll(<String,String>{'sub_id': sub_id.toString()});

        print(request_body);

        return http.post(url, body: request_body);
      case 'delete':
        return http.delete('$url/$userToken/${sub_id.toString()}');
    }
  }
}