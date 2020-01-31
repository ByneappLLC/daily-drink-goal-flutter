import 'package:daily_beer_goal_fl/core/utils/utils.dart';
import 'package:daily_beer_goal_fl/data/models/week_data.dart';
import 'package:rxdart/rxdart.dart';

class BeersStreams {
  BehaviorSubject<List<WeekData>> _weeklyController =
      BehaviorSubject<List<WeekData>>();
  loadBeers(List<WeekData> beers) => _weeklyController.sink.add(beers);
  Stream<List<WeekData>> get weeklyDrinks => _weeklyController.stream;

  BehaviorSubject<int> _goalController = BehaviorSubject<int>();
  setGoal(int g) => _goalController.sink.add(g);

  BehaviorSubject<double> _drankController = BehaviorSubject<double>();
  setDrank(double d) => _drankController.sink.add(d);

  Observable<double> get drinkingProgress => Observable.combineLatest2(
      _goalController, _drankController, calculateProgress);

  closeStreams() {
    _weeklyController.close();
    _goalController.close();
    _drankController.close();
  }
}
