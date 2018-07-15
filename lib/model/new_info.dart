import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:boono_mobile/route/api_routes.dart';
import 'package:boono_mobile/config/db_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewInfo {
  // shared_preferencesのnew_infoを更新する
  static void updateNewInfo(bool new_info) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('new_info', new_info);
  }

  //shared_preferencesのnew_infoを返す
  static Future<bool> new_info() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('new_info') ?? true;
  }

  // new_infoをサーバーからもらう
  static void  fetchNewInfo() async {
    DBManager db = new DBManager();
    final String userToken = await db.fetchUserToken();

    var res = await http.get(NewInfoURL + '/$userToken');
    bool new_info = res.body == 'true';

    await NewInfo.updateNewInfo(new_info);
  }
}