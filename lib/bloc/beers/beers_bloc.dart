import 'package:daily_beer_goal_fl/bloc/base_bloc.dart';
import 'package:daily_beer_goal_fl/bloc/beers/streams.dart';
import 'package:daily_beer_goal_fl/core/failure.dart';
import 'package:daily_beer_goal_fl/core/utils/utils.dart';
import 'package:daily_beer_goal_fl/data/models/drink.dart';
import 'package:daily_beer_goal_fl/usecase/add_drink_usecase.dart';
import 'package:daily_beer_goal_fl/usecase/delete_drinks_usecase.dart';
import 'package:daily_beer_goal_fl/usecase/get_drinks_usecase.dart';

class BeersBloc extends BaseBloc {
  final BeersStreams streams;
  final GetDrinks _getDrinks;
  final AddDrink _addDrink;
  final DeleteDrinks _deleteDrinks;
  DateTime _today;
  int _goal = 5000;

  BeersBloc(this._getDrinks, this._addDrink, this._deleteDrinks)
      : streams = BeersStreams() {
    _today = DateTime.now();
    _init();
  }

  _init() {
    streams.setGoal(_goal);

    _fetchDrinks();
  }

  _fetchDrinks() {
    final today = DateTime(_today.year, _today.month, _today.day, 23, 59)
        .millisecondsSinceEpoch;

    _getDrinks(today, (e) => e.fold(_handleFailure, _handleDrinks));
  }

  _handleFailure(Failure f) {}

  _handleDrinks(List<Drink> drinks) {
    var drankToday = 0.0;
    drinks.forEach((d) {
      if (DateTime.fromMillisecondsSinceEpoch(d.date).day == _today.day) {
        if (d.amount != null) {
          drankToday += d.amount;
        }
      }
    });
    Future.delayed(Duration(milliseconds: 500), () {
      streams.setDrank(drankToday);
      streams.loadBeers(generateWeekData(drinks, _today, _goal));
    });
  }

  addDrink(Drink drink) {
    if (drink != null) {
      _addDrink(drink, (e) => e.fold(_handleFailure, (res) => _fetchDrinks()));
    }
  }

  deleteAll() async {
    _deleteDrinks(null, (e) {
      final option = e.toOption();
      if (option.isSome()) {
        _fetchDrinks();
      }
    });
  }

  @override
  void dispose() {
    streams.closeStreams();
  }
}
