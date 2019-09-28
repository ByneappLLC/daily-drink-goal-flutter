import 'package:daily_beer_goal_fl/ui/add_drink/add_drink_screen.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AddDrinkScreen.routeName:
        return AddDrinkScreen.newInstance();
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
