import 'dart:io';

import 'package:daily_beer_goal_fl/data/models/beer_type.dart';
import 'package:daily_beer_goal_fl/data/models/drink.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

const BEERS = 'beers';

class BeersDb {
  static Future<void> openDb() async {
    final Directory path = await getApplicationDocumentsDirectory();
    Hive.init(path.path);
    Hive.registerAdapter(DrinkAdapter(), 0);
    Hive.registerAdapter(BeerTypeAdapter(), 1);
  }

  static Future<void> closeDb() => Hive.close();

  static Future<Box> getBeersBox() => Hive.openBox(BEERS, lazy: true);
  static Future<void> closeBeersBox() => Hive.box(BEERS).close();
}
