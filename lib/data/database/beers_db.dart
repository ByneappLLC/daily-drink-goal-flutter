import 'dart:async';

import 'package:daily_beer_goal_fl/data/database/v1_migration.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BeersDb {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDB();
      return _db;
    }
  }

  Future<Database> initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "dailybeergoal.db");

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async => migrateToV1(db);

  Future closeDb() async {
    var dbClient = await db;
    dbClient.close();
  }
}
