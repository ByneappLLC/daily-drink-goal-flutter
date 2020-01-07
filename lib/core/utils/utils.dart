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
              drank += d.amount;
            }
          });
          return MapEntry(
              index,
              WeekData(
                  formatDate(today, ["D"]), calculateProgress(goal, drank)));
        } else {
          var drank = 0.0;
          final day = today.subtract(Duration(days: index));
          drinks.forEach((d) {
            if (DateTime.fromMillisecondsSinceEpoch(d.date).day == day.day) {
              drank += d.amount;
            }
          });
          return MapEntry(index,
              WeekData(formatDate(day, ["D"]), calculateProgress(goal, drank)));
        }
      })
      .values
      .toList();
}
