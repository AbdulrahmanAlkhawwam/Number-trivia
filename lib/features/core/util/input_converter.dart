import 'package:dartz/dartz.dart';
import 'package:number_trivia/features/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final intNumber = int.parse(str);
      if (intNumber < 0) {
        throw const FormatException();
      } else {
        return Right(intNumber);
      }
    } on FormatException {
      return const Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure({super.properties});
}
