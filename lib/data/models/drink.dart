import 'package:daily_beer_goal_fl/data/models/beer_type.dart';

class Drink {
  final int amount;
  final BeerType type;
  final DateTime date;
  final bool synced;

  Drink(this.amount, this.type, this.date, this.synced);
}
