import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';

class GetConcreteNumberTrivia
    implements UseCase<NumberTrivia, NumberTriviaParams> {
  GetConcreteNumberTrivia({required this.repository});

  final NumberTriviaRepository repository;

  @override
  Future<Either<Failure, NumberTrivia>> call(NumberTriviaParams params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class NumberTriviaParams extends Equatable {
  final int number;

  const NumberTriviaParams({required this.number});

  @override
  List<Object?> get props => [number];
}
