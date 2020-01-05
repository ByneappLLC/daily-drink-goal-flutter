import 'package:daily_beer_goal_fl/bloc/base_bloc.dart';
import 'package:daily_beer_goal_fl/bloc/beers/streams.dart';
import 'package:daily_beer_goal_fl/data/models/drink.dart';

class BeersBloc extends BaseBloc {
  final BeersStreams streams;
  DateTime _today;
  int _amountDrankToday;

  BeersBloc() : streams = BeersStreams() {
    _today = DateTime.now();
    _init();
  }

  _init() async {
    streams.setGoal(5000);
    _getTodaysDrinks();

    streams.drinkingProgress.listen((d) {
      print(d);
    });
  }

  _getTodaysDrinks() {
    streams.setDrank(_amountDrankToday);
  }

  _getWeeklyDrinks() {}

  bool _isInThePastWeek(DateTime date) {}

  addDrink(Drink drink) {
    if (drink != null) {
      print(drink.amount);
    }
  }

  deleteAll() async {}

  @override
  void dispose() {
    streams.closeStreams();
  }
}
