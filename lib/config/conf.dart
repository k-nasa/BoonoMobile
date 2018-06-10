import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:boono_mobile/config/db_manager.dart';
import 'package:boono_mobile/route/api_routes.dart';

class Config {
  final DBManager dbManager = new DBManager();
  String token;

  //アプリを開いたときにcall
  void init() async {
    await dbManager.openDB();
    
    if (await setToken() == null) {
      await generateToken();
    }
    setToken();
  }

  Future<String> setToken() async {
    final List config =  await dbManager.database.rawQuery("select * from config");
    if (config.isEmpty) return null;

    token = config.first['token'];

    return config.first['token'];
  }

  void generateToken() async {
    final http.Response res = await http.post(UserCreateURL);

    print(res.statusCode);
    if(res.statusCode == 200)
      dbManager.database.insert('config', { 'token': res.body });
  }
}
