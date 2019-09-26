import 'package:daily_beer_goal_fl/ui/home/widgets/day_progress.dart';
import 'package:flutter/material.dart';

class WeekChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          DayProgress(
            progress: 0.1,
          ),
          DayProgress(
            progress: 0.32,
          ),
          DayProgress(
            progress: 0.12,
          ),
          DayProgress(
            progress: 0.42,
          ),
          DayProgress(
            progress: 0.2,
          ),
          DayProgress(
            progress: 0.02,
          ),
          DayProgress(
            progress: 0.87,
          )
        ],
      ),
    );
  }
}
