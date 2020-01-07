import 'package:daily_beer_goal_fl/data/models/drink.dart';
import 'package:daily_beer_goal_fl/data/models/week_data.dart';
import 'package:date_format/date_format.dart';

double calculateProgress(int goal, double drank) {
  final progress = drank / goal;

  if (progress > 1) {
    return 1;
  } else if (progress == 0) {
    return 0.01;
  } else {
    return progress;
  }
}

List<WeekData> generateWeekData(List<Drink> drinks, DateTime today, int goal) {
  List<WeekData> weekList = List(DateTime.daysPerWeek);

  return weekList
      .asMap()
      .map((index, data) {
        if (index == 0) {
          var drank = 0.0;
          drinks.forEach((d) {
            if (DateTime.fromMillisecondsSinceEpoch(d.date).day == today.day) {
              if (d.amount != null) {
                drank += d.amount;
              }
            }
          });
          final weekDay = formatDate(today, ["D"]).substring(0, 1);
          return MapEntry(
              index, WeekData(weekDay, calculateProgress(goal, drank)));
        } else {
          var drank = 0.0;
          final day = today.subtract(Duration(days: index));
          drinks.forEach((d) {
            if (DateTime.fromMillisecondsSinceEpoch(d.date).day == day.day) {
              if (d.amount != null) {
                drank += d.amount;
              }
            }
          });

          final weekDay = formatDate(day, ["D"]).substring(0, 1);
          return MapEntry(
              index, WeekData(weekDay, calculateProgress(goal, drank)));
        }
      })
      .values
      .toList()
      .reversed
      .toList();
}
