import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:boono_mobile/config/db_manager.dart';
import 'package:boono_mobile/route/api_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Config {
  final DBManager dbManager = new DBManager();
  String token;

  //アプリを開いたときにcall
  Future<bool>init() async {
    await dbManager.openDB();

    if (!await isTokenSetting()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await generateToken();
    }

    return isTokenSetting();
  }

  Future<bool> isTokenSetting() async {
    final List<Map<String, dynamic>> config =  await dbManager.database.rawQuery('select * from config');
    if(config == null || config.isEmpty)
      return false;

    return config?.first['token'] != null;
  }

  Future<void> generateToken() async {
    http.Response res;
    try{
      res = await http.post(UserCreateURL);
    }catch(e) {
      return ;
    }

    if(res.statusCode == 200) {
      await dbManager.database.insert('config', <String, dynamic>{ 'token': res.body });
      await putDeviceToken();
    }
  }

  // FIXME iOS,Android両者のDeviceKeyを使えるようになればこの処理は不要になる
  Future<void> putDeviceToken() async {
    final DBManager db = DBManager();
    final String userToken = await db.fetchUserToken();

    final FirebaseMessaging _fm = FirebaseMessaging();
    _fm.configure();

    _fm.getToken().then((String token) async{
      http.patch(
        UserUpdateURL,
        body: {
          'token': userToken,
          'device_token': token,
        }
      );
    });
  }
}