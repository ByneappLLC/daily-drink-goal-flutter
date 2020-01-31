import 'package:daily_beer_goal_fl/app/navigator.dart';
import 'package:daily_beer_goal_fl/app/router.dart';
import 'package:daily_beer_goal_fl/di/di_instance.dart';
import 'package:daily_beer_goal_fl/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: FlutterConfig.get('APP_NAME'),
      theme: ThemeData(
          primaryColor: Colors.white, colorScheme: ColorScheme.light()),
      initialRoute: HomeScreen.routeName,
      onGenerateRoute: Router.generateRoute,
      navigatorKey: sl<NavigationService>().navigatorKey,
    );
  }
}
