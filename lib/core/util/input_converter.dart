import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class InputConverter {
  /// strToInt is function get [String] and take you a [Int] or throw [ParsingFailure]
  Either<Failure, int> strToInt(String str) {
    try {
      final intNumber = int.parse(str);
      if (intNumber < 0) {
        throw const ParsingFailure("can't format this input");
      } else {
        return Right(intNumber);
      }
    } catch (e) {
      return Left(ParsingFailure(e.toString()));
    }
  }
}
