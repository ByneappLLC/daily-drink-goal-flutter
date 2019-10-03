import 'package:daily_beer_goal_fl/data/models/beer_type.dart';
import 'package:hive/hive.dart';

part 'drink.g.dart';

@HiveType()
class Drink {
  @HiveField(0)
  final int amount;

  @HiveField(1)
  final BeerType type;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final bool synced;

  Drink(this.amount, this.type, this.date, this.synced);
}
