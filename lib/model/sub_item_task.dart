import 'package:boono_mobile/config/db_manager.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class SubItemTask {
  String http_method;
  String url;
  int model_id;
  bool flag = false;

  static const String TABLE_NAME = 'subscription_item_tasks';

  void save() async {
    final db = new DBManager();
    await db.openDB();

    await db.database.insert(TABLE_NAME, _toMap());
  }

  Future<bool> exe() async {
    final db = new DBManager();
    String userToken = await db.fetchUserToken();

    try {
      final res = await http.post(
          url,
      );

      if (res.statusCode == 201)
        return true;
      else
        return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Map<String, dynamic> _toMap() =>
      <String, dynamic> {
        'http_method': http_method,
        'url': url,
        'model_id': model_id,
        'flag': flag,
      };
}