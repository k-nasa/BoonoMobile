import 'package:boono_mobile/route/api_routes.dart';
import 'package:boono_mobile/config/db_manager.dart';
import 'dart:async';
import 'sub_item_task.dart';
import 'package:boono_mobile/model/new_info.dart';

class SubscriptionItem {
  String content;
  String type;
  int id;

  static const String TABLE_NAME = 'subscription_items';

  SubscriptionItem({this.content, this.type, this.id});

  Future<bool> save() async {
    DBManager db = new DBManager();
    await db.openDB();
    try {
      id = await db.database.insert(TABLE_NAME, toMap());

     var task = new SubItemTask(http_method: 'post',sub_id: id, url: SubscriptionCreateURL);
     task.save();
     SubItemTask.execute();
    }catch(e) {
      return false;
    }

    NewInfo.updateNewInfo(true);

    return true;
  }

  static Future<List<SubscriptionItem>> all() async{
    DBManager db = new DBManager();
    await db.openDB();

    final List<Map> subItemsMap =  await db.database.rawQuery("select * from $TABLE_NAME");
    if (subItemsMap.isEmpty) return null;
    List<SubscriptionItem> subItems = [];

    for(var subItemMap in subItemsMap)
      subItems.add(SubscriptionItem.fromMap(subItemMap));

    return subItems;
  }

  Future<bool> delete() async {
    DBManager db = new DBManager();
    await db.openDB();

    int count = await db.database.delete(TABLE_NAME, where: 'id= ?', whereArgs: <int>[id]);

    var task = new SubItemTask(http_method: 'delete',sub_id: id, url: SubscriptionDeleteURL);
    task.save();
    SubItemTask.execute();

    NewInfo.updateNewInfo(true);
    return count == 1;
  }


  Map toMap() =>
      <String, dynamic>{
        'type': type,
        'content': content,
      };

  SubscriptionItem.fromMap(Map map) {
    id = map['id'];
    content = map['content'];
    type = map['type'];
  }

  static Future<SubscriptionItem> find(int id) async{
    DBManager db = new DBManager();
    await db.openDB();

    List<Map> maps = await db.database.query(TABLE_NAME,
        where: "id = ?",
        whereArgs: <int>[id]
    );
    return SubscriptionItem.fromMap(maps.first);
  }
}