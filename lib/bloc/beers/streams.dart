import 'package:daily_beer_goal_fl/data/models/drink.dart';
import 'package:rxdart/rxdart.dart';

class BeersStreams {
  BehaviorSubject<List<Drink>> _beerController = BehaviorSubject<List<Drink>>();
  loadBeers(List<Drink> beers) => _beerController.sink.add(beers);
  Stream<List<Drink>> get myBeers => _beerController.stream;

  closeStreams() {
    _beerController.close();
  }
}
