import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:boono_mobile/config/db_manager.dart';
import 'package:boono_mobile/route/api_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Config {
  final DBManager dbManager = new DBManager();
  String token;

  //アプリを開いたときにcall
  Future<bool>init() async {
    await dbManager.openDB();

    if (await setToken() == null) {
      await generateToken();
    }
    return setToken() != null;
  }

  Future<String> setToken() async {
    final List config =  await dbManager.database.rawQuery("select * from config");
    if (config.isEmpty) return null;

    token = config.first['token'];

    return config.first['token'];
  }

  void generateToken() async {
    final http.Response res = await http.post(UserCreateURL);

    if(res.statusCode == 200) {
      await dbManager.database.insert('config', <String, dynamic>{ 'token': res.body });
      await putDeviceToken();
    }
  }

  void putDeviceToken() async {
    DBManager db = new DBManager();
    String userToken = await db.fetchUserToken();

    FirebaseMessaging _fm = new FirebaseMessaging();
    _fm.configure();

    _fm.getToken().then((token) async{
      print(token);
      print(userToken);
      final http.Response res = await http.patch(
        UserUpdateURL,
        body: {
          'token': userToken,
          'device_token': token,
        }
      );
      print(res.body);
    });
  }
}
