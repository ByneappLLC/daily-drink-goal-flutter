import 'package:daily_beer_goal_fl/bloc/beers/beers_bloc.dart';
import 'package:daily_beer_goal_fl/data/database/beers_db.dart';
import 'package:kiwi/kiwi.dart';

part 'injector.g.dart';

abstract class Injector {
  void configure() {
    _configureFactories();
  }

  @Register.singleton(BeersDb)
  @Register.factory(BeersBloc)
  void _configureFactories();
}

void inject() {
  var injector = _$Injector();
  injector.configure();
}
