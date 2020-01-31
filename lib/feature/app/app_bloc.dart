import 'package:daily_beer_goal_fl/app/navigator.dart';
import 'package:daily_beer_goal_fl/core/base_bloc.dart';

class AppBloc extends BaseBloc {
  // with this we can control navigation from anywhere in the App
  final NavigationService navigationService;

  AppBloc(this.navigationService);

  @override
  void dispose() {}
}
