import 'package:daily_beer_goal_fl/core/failure.dart';
import 'package:daily_beer_goal_fl/core/use_case.dart';
import 'package:daily_beer_goal_fl/data/database/beers_db.dart';
import 'package:daily_beer_goal_fl/data/models/drink.dart';
import 'package:dartz/dartz.dart';

class DeleteDrinks extends UseCase<void, int> {
  final BeersDb _beersDb;

  DeleteDrinks(this._beersDb);

  @override
  Future<Either<Failure, int>> execute(void params) async {
    final client = await _beersDb.db;

    try {
      final res = await client.delete(Drink.TABLE_NAME);
      return Right(res);
    } catch (e) {
      return Left(DatabaseError());
    }
  }
}
