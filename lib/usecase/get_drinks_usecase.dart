import 'package:daily_beer_goal_fl/core/failure.dart';
import 'package:daily_beer_goal_fl/core/use_case.dart';
import 'package:daily_beer_goal_fl/data/database/beers_db.dart';
import 'package:daily_beer_goal_fl/data/models/drink.dart';
import 'package:dartz/dartz.dart';

class GetDrinks extends UseCase<int, List<Drink>> {
  final BeersDb _beersDb;

  GetDrinks(this._beersDb);
  @override
  Future<Either<Failure, List<Drink>>> execute(int params) async {
    final lastWeek = params - 604800000;
    final client = await _beersDb.db;

    try {
      final drinks = await client.query(Drink.TABLE_NAME);

      return Right(drinks.map((d) => Drink.fromMap(d)).toList());
    } catch (e) {
      return Left(DatabaseError());
    }
  }
}
