import 'package:daily_beer_goal_fl/ui/home/widgets/main_content.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[MainContent()],
      ),
    );
  }
}
