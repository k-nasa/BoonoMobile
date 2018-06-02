import 'dart:io';
import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBManager {
  Database database;

  Future openDB() async {
    if (database == null) {
      Directory directory = await getApplicationDocumentsDirectory();
      database = await openDatabase(
          join(directory.path, 'Boonoigjsg.db'), //path
          version: 1,
          onCreate: (Database db, int version) async {
            createConfigTable(db);
          }
      );
    }
  }

  createConfigTable(Database db) {
    final String TABLE_NAME = "config";
    final String TOKEN = "token";

    db.execute(
      '''create table $TABLE_NAME(
        $TOKEN text not null)'''
    );

    print('CREATE config TABLE');
  }
}