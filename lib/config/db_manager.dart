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
        join(directory.path, 'gowneonf.db'), //path
        version: 1,
        onCreate: (Database db, int version) async {
          createConfigTable(db);
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

  Future<String> fetchUserToken() async {
    await openDB();

    final config =  await database.rawQuery('select * from config');

    if (config.isEmpty) return null ;

    return config.first['token'];
  }
}