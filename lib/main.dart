import 'package:daily_beer_goal_fl/app/app.dart';
import 'package:daily_beer_goal_fl/data/database/beers_db.dart';
import 'package:daily_beer_goal_fl/di/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  await BeersDb.openDb();

  inject();

  runApp(App());
}
