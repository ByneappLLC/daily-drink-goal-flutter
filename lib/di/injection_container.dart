import 'package:daily_beer_goal_fl/bloc/beers/beers_bloc.dart';
import 'package:daily_beer_goal_fl/data/database/beers_db.dart';
import 'package:daily_beer_goal_fl/di/di_instance.dart';
import 'package:daily_beer_goal_fl/usecase/add_drink_usecase.dart';
import 'package:daily_beer_goal_fl/usecase/delete_drinks_usecase.dart';
import 'package:daily_beer_goal_fl/usecase/get_drinks_usecase.dart';

init() {
  sl.registerSingleton<BeersDb>(BeersDb());

  sl.registerFactory<GetDrinks>(() => GetDrinks(sl()));
  sl.registerFactory<AddDrink>(() => AddDrink(sl()));
  sl.registerFactory<DeleteDrinks>(() => DeleteDrinks(sl()));

  sl.registerLazySingleton<BeersBloc>(() => BeersBloc(sl(), sl(), sl()));
}
