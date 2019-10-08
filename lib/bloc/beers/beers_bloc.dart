import 'package:daily_beer_goal_fl/bloc/base_bloc.dart';
import 'package:daily_beer_goal_fl/bloc/beers/streams.dart';
import 'package:daily_beer_goal_fl/data/beers_db.dart';
import 'package:daily_beer_goal_fl/data/models/drink.dart';
import 'package:hive/hive.dart';

class BeersBloc extends BaseBloc {
  final BeersStreams streams;
  Box _beersBox;
  Box _goalBox;
  DateTime _today;
  int _amountDrankToday;

  BeersBloc() : streams = BeersStreams() {
    _today = DateTime.now();
    _init();
  }

  _init() async {
    _beersBox = await BeersDb.getBeersBox();
    _goalBox = await BeersDb.getGoalBox();
    final goal = _goalBox.get('myGoal', defaultValue: 5000) as int;

    streams.setGoal(goal);
    _getTodaysDrinks();
    _beersBox.watch().listen((d) {
      print(d);
      _amountDrankToday += (d.value as Drink).amount;
      streams.setDrank(_amountDrankToday);
    });

    streams.drinkingProgress.listen((d) {
      print(d);
    });
  }

  _getTodaysDrinks() {
    if (_beersBox.length > 0) {
      final drinksToday = _beersBox.values.where((d) {
        return (d as Drink).date.day == _today.day;
      }).map((d) {
        print(d);
        return (d as Drink).amount;
      }).reduce((d, d2) => d + d2);

      _amountDrankToday = drinksToday;
    } else {
      _amountDrankToday = 0;
    }
    print(_amountDrankToday);
    streams.setDrank(_amountDrankToday);
  }

  _getWeeklyDrinks() {
    _beersBox.values.where((d) {
      final month = (d as Drink).date.month;

      return month == _today.month;
    });
  }

  bool _isInThePastWeek(DateTime date) {}

  addDrink(Drink drink) {
    if (drink != null) {
      print(drink.amount);
      _beersBox.add(drink);
    }
  }

  deleteAll() {
    print('Delete ass');
  }

  @override
  void dispose() {
    streams.closeStreams();
  }
}
