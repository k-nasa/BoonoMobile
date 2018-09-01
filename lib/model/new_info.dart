import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:boono_mobile/route/api_routes.dart';
import 'package:boono_mobile/config/db_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewInfo {
  // shared_preferencesのnew_infoを更新する
  static Future<void> updateNewInfo(bool newInfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('new_info', newInfo);
  }

  //shared_preferencesのnew_infoを返す
  static Future<bool> newInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('new_info') ?? true;
  }

  // new_infoをサーバーからもらう
  static Future<void> fetchNewInfo() async {
    final DBManager db = new DBManager();
    final String userToken = await db.fetchUserToken();

    try {
      final http.Response res = await http.get(NewInfoURL + '/$userToken');
      final bool newInfo = res.body == 'true';

      await NewInfo.updateNewInfo(newInfo);
    } catch (e) {
      print(e);
      await NewInfo.updateNewInfo(false);
    }
  }
}
