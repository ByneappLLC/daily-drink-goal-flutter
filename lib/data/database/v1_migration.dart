import 'package:sqflite/sqflite.dart';

Future<List<dynamic>> migrateToV1(Database db) {
  var batch = db.batch();
  _createSchema(batch);
  return batch.commit();
}

_createSchema(Batch batch) {}
