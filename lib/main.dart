import 'package:daily_beer_goal_fl/app/app.dart';
import 'package:daily_beer_goal_fl/core/base_bloc.dart';
import 'package:daily_beer_goal_fl/di/di_instance.dart';
import 'package:daily_beer_goal_fl/di/injection_container.dart' as di;
import 'package:daily_beer_goal_fl/feature/app/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  di.init();

  runApp(BlocProvider(child: App(), bloc: sl<AppBloc>()));
}
