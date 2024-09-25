import 'package:dartz/dartz.dart';

import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  GetRandomNumberTrivia({required this.repository});

  final NumberTriviaRepository repository;

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
