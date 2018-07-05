import 'dart:io';
import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBManager {
  Database database;

  void openDB() async {
    if (database != null)
      return ;

    Directory directory = await getApplicationDocumentsDirectory();
    database = await openDatabase(
        join(directory.path, 'Bfisngoiwovneifjvode.db'), //path
        version: 1,
        onCreate: (Database db, int version) async {
          createConfigTable(db);
          createSubItemTasksTable(db);
        }
    );
  }

  void createConfigTable(Database db) {
    const String TABLE_NAME = 'config';
    const String TOKEN = 'token';

    db.execute(
      '''create table $TABLE_NAME(
        $TOKEN text not null)'''
    );
  }

  void createSubItemTasksTable(Database db) {
    const String TABLE_NAME = 'subscription_item_tasks';
    const String HTTP_METHOD = 'http_method';
    const String URL = 'url';
    const String SUB_ID = 'sub_id';
    const String FLAG = 'flag';

    db.execute(
        '''create table $TABLE_NAME(
        $HTTP_METHOD string not null,
        $URL text not null,
        $SUB_ID integer not null,
        $FLAG boolean not null 
        )'''
    );
  }

  Future<String> fetchUserToken() async {
    await openDB();

    final config =  await database.rawQuery('select * from config');

    if (config.isEmpty) return null ;

    return config.first['token'];
  }
}