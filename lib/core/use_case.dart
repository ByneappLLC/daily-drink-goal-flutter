import 'package:daily_beer_goal_fl/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<P, R> {
  Future<Either<Failure, R>> _execute(P params);

  call(P params, Function(Either<Failure, R>) onResult) async {
    final result = await _execute(params);
    onResult(result);
  }

  Stream<Either<Failure, R>> stream(P params) => _execute(params).asStream();
}
