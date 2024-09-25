import 'package:dartz/dartz.dart';

import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../../core/error/failures.dart';

class GetConcreteNumberTrivia
    implements UseCase<NumberTrivia, NumberTriviaParams> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia({required this.repository});

  @override
  Future<Either<Failure, NumberTrivia>> call(NumberTriviaParams params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}
