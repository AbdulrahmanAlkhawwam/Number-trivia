import 'package:dartz/dartz.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NumberTriviaParams {
  final int number;

  const NumberTriviaParams({required this.number});
}

class NoParams {
  const NoParams();
}
