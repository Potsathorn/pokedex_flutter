// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:pokedex_flutter/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> execute(Params params);
}
