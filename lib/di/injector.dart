import 'package:daily_beer_goal_fl/bloc/beers/beers_bloc.dart';
import 'package:daily_beer_goal_fl/data/database/beers_db.dart';
import 'package:daily_beer_goal_fl/usecase/add_drink_usecase.dart';
import 'package:daily_beer_goal_fl/usecase/delete_drinks_usecase.dart';
import 'package:daily_beer_goal_fl/usecase/get_drinks_usecase.dart';
import 'package:kiwi/kiwi.dart';

part 'injector.g.dart';

abstract class Injector {
  void configure() {
    _configureFactories();
  }

  @Register.singleton(BeersDb)
  @Register.factory(GetDrinks)
  @Register.factory(AddDrink)
  @Register.factory(DeleteDrinks)
  @Register.factory(BeersBloc)
  void _configureFactories();
}

void inject() {
  var injector = _$Injector();
  injector.configure();
}
