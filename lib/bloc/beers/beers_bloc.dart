import 'package:daily_beer_goal_fl/bloc/base_bloc.dart';
import 'package:daily_beer_goal_fl/bloc/beers/streams.dart';
import 'package:daily_beer_goal_fl/data/models/drink.dart';
import 'package:daily_beer_goal_fl/usecase/get_drinks_usecase.dart';

class BeersBloc extends BaseBloc {
  final BeersStreams streams;
  final GetDrinks _getDrinks;
  DateTime _today;
  int _amountDrankToday;

  BeersBloc(this._getDrinks) : streams = BeersStreams() {
    _today = DateTime.now();
    _init();
  }

  _init() async {
    streams.drinkingProgress.listen((d) {
      print("Drinking progress $d");
    });
    streams.setGoal(5000);
    _getTodaysDrinks();
  }

  _getTodaysDrinks() {
    final today = DateTime(_today.year, _today.month, _today.day, 23, 59)
        .millisecondsSinceEpoch;

    final lastWeek = today - 604800000;

    Future.delayed(Duration(milliseconds: 800), () => {streams.setDrank(2300)});
  }

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
