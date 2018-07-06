import 'package:boono_mobile/route/api_routes.dart';
import 'package:http/http.dart'as http ;
import 'package:boono_mobile/config/db_manager.dart';
import 'dart:convert';
import 'dart:async';

class SubscriptionItem {
  String content;
  String type;
  int id;

  static const String TABLE_NAME = 'subscription_items';

  SubscriptionItem({this.content, this.type, this.id});

  Future<bool> save() async {
    DBManager db = new DBManager();
    await db.openDB();
    print(_toMap());
    try {
      id = await db.database.insert(TABLE_NAME, _toMap());
    }catch(e) {
      return false;
    }

    return true;
  }

  Future<bool> delete() async {
  }

  static Future<List<SubscriptionItem>> all() async{
  }

  Map _toMap() =>
      <String, dynamic>{
        'type': type,
        'content': content,
      };
}