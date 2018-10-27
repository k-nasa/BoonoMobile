import 'dart:async';
import 'package:boono_mobile/route/api_routes.dart';
import 'package:boono_mobile/config/db_manager.dart';
import 'package:boono_mobile/model/new_info.dart';
import 'sub_item_task.dart';

class SubscriptionItem {
  SubscriptionItem({this.content, this.type, this.id});

  SubscriptionItem.fromMap(Map map) {
    id = map['id'];
    content = map['content'];
    type = map['type'];
  }

  String content;
  String type;
  int id;

  static const String TABLE_NAME = 'subscription_items';

  Future<bool> save() async {
    DBManager db = new DBManager();
    await db.openDB();
    try {
      id = await db.database.insert(TABLE_NAME, toMap());

      var task = new SubItemTask(
          httpMethod: 'post', subId: id, url: SubscriptionCreateURL);
      task.save();
      SubItemTask.execute();
    } catch (e) {
      return false;
    }

    NewInfo.updateNewInfo(true);

    return true;
  }

  static Future<List<SubscriptionItem>> all() async {
    DBManager db = new DBManager();
    await db.openDB();

    final List<Map> subItemsMap =
        await db.database.rawQuery('select * from $TABLE_NAME');
    if (subItemsMap.isEmpty) return null;

    List<SubscriptionItem> subItems = [];

    for (var subItemMap in subItemsMap)
      subItems.add(SubscriptionItem.fromMap(subItemMap));

    return subItems;
  }

  Future<bool> delete() async {
    DBManager db = new DBManager();
    await db.openDB();

    int count = await db.database
        .delete(TABLE_NAME, where: 'id= ?', whereArgs: <int>[id]);

    if (count == 1) {
      var task = new SubItemTask(
          httpMethod: 'delete', subId: id, url: SubscriptionDeleteURL);
      task.save();
      SubItemTask.execute();
      NewInfo.updateNewInfo(true);
    }

    return count == 1;
  }

  Map toMap() => <String, dynamic>{
        'id': id,
        'type': type,
        'content': content,
      };

  static Future<SubscriptionItem> find(int id) async {
    DBManager db = new DBManager();
    await db.openDB();

    List<Map> maps = await db.database
        .query(TABLE_NAME, where: 'id = ?', whereArgs: <int>[id]);
    return SubscriptionItem.fromMap(maps.first);
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    return other is SubscriptionItem &&
        other.id == id &&
        other.type == type &&
        other.content == content;
  }
}
