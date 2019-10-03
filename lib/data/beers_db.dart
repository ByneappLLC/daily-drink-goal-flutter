import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

const BEERS = 'beers';

class BeersDb {
  static Future<void> openDb() async {
    final Directory path = await getApplicationDocumentsDirectory();
    Hive.init(path.path);
  }

  static Future<void> closeDb() => Hive.close();

  static Future<LazyBox> getBeersBox() => Hive.openBox(BEERS, lazy: true);
  static Future<void> closeBeersBox() => Hive.box(BEERS).close();
}
