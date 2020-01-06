import 'package:daily_beer_goal_fl/core/failure.dart';
import 'package:daily_beer_goal_fl/core/use_case.dart';
import 'package:daily_beer_goal_fl/data/database/beers_db.dart';
import 'package:daily_beer_goal_fl/data/models/drink.dart';
import 'package:dartz/dartz.dart';

class AddDrink extends UseCase<Drink, int> {
  final BeersDb _beersDb;

  AddDrink(this._beersDb);
  @override
  Future<Either<Failure, int>> execute(Drink params) async {
    final client = await _beersDb.db;
    try {
      final res = await client.insert(Drink.TABLE_NAME, params.toMap());
      return Right(res);
    } catch (e) {
      return Left(InsertError());
    }
  }
}
