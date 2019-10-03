import 'package:daily_beer_goal_fl/bloc/base_bloc.dart';
import 'package:daily_beer_goal_fl/bloc/beers/streams.dart';
import 'package:daily_beer_goal_fl/data/beers_db.dart';
import 'package:daily_beer_goal_fl/data/models/drink.dart';
import 'package:hive/hive.dart';

class BeersBloc extends BaseBloc {
  final BeersStreams streams;
  LazyBox _beersBox;

  BeersBloc() : streams = BeersStreams() {
    _init();
    print('Bloc created');
  }

  _init() async {
    _beersBox = await BeersDb.getBeersBox();
    _beersBox.watch().listen((d) {
      print(d.value);
    });
  }

  addDrink(Drink drink) {
    if (drink != null) {
      _beersBox.add(drink);
    }
  }

  @override
  void dispose() {
    streams.closeStreams();
  }
}
