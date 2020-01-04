import 'package:daily_beer_goal_fl/data/models/drink.dart';
import 'package:rxdart/rxdart.dart';

class BeersStreams {
  BehaviorSubject<List<Drink>> _weeklyBeerController =
      BehaviorSubject<List<Drink>>();
  loadBeers(List<Drink> beers) => _weeklyBeerController.sink.add(beers);
  Stream<List<Drink>> get myBeers => _weeklyBeerController.stream;

  BehaviorSubject<int> _goalController = BehaviorSubject<int>();
  setGoal(int g) => _goalController.sink.add(g);

  BehaviorSubject<int> _drankController = BehaviorSubject<int>();
  setDrank(int d) => _drankController.sink.add(d);

  Observable<double> get drinkingProgress =>
      Observable.combineLatest2(_goalController, _drankController,
          (goal, drank) {
        final progress = drank / goal;

        if (progress > 1) {
          return 1;
        } else if (progress == 0) {
          return 0.01;
        } else {
          return progress;
        }
      });

  closeStreams() {
    _weeklyBeerController.close();
    _goalController.close();
    _drankController.close();
  }
}
