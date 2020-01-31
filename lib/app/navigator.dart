import 'package:flutter/cupertino.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  pop<T extends Object>([T res]) => navigatorKey.currentState.pop(res);

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }
}
