import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBManager {
  Database database;

  Future<void> openDB() async {
    if (database != null)
      return ;

    final Directory directory = await getApplicationDocumentsDirectory();
    database = await openDatabase(
        join(directory.path, 'hog453edg234567876543.db'), //path
        version: 1,
        onCreate: (Database db, int version) async {
          createConfigTable(db);
          createSubscriptionItemsTable(db);
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

  void createSubscriptionItemsTable(Database db){
    const String TABLE_NAME = 'subscription_items';
    const String ID = 'id';
    const String TYPE = 'type';
    const String CONTENT = 'content';

    db.execute(
        '''
        create table $TABLE_NAME(
        $ID integer PRIMARY KEY AUTOINCREMENT,
        $TYPE string not null,
        $CONTENT text not null
        )
    ''');
  }

  void createSubItemTasksTable(Database db) {
    const String TABLE_NAME = 'subscription_item_tasks';
    const String HTTP_METHOD = 'http_method';
    const String URL = 'url';
    const String SUB_ID = 'sub_id';

    db.execute(
        '''create table $TABLE_NAME(
        $HTTP_METHOD string,
        $URL text not null,
        $SUB_ID integer not null
        )'''
    );
  }

  Future<String> fetchUserToken() async {
    await openDB();

    final config =  await database.rawQuery('select * from config');

    if (config.isEmpty)
      return null ;

    return config.first['token'];
  }
}