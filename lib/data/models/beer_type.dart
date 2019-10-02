import 'package:hive/hive.dart';

part 'beer_type.g.dart';

@HiveType()
enum BeerType {
  @HiveField(0)
  CanOrSmallBottle,

  @HiveField(1)
  LargeBottle,

  @HiveField(2)
  ManualEntry
}
