import 'package:daily_beer_goal_fl/data/models/drink.dart';
import 'package:sqflite/sqflite.dart';

Future<List<dynamic>> migrateToV1(Database db) {
  var batch = db.batch();
  _createSchema(batch);
  return batch.commit();
}

_createSchema(Batch batch) {
  batch.execute("""CREATE TABLE IF NOT EXISTS
      ${Drink.TABLE_NAME}(${Drink.COLUMN_ID} INTEGER PRIMARY KEY,
      ${Drink.COLUMN_DATE} INTEGER,
      ${Drink.COLUMN_AMOUNT} REAL)
      """);
}
