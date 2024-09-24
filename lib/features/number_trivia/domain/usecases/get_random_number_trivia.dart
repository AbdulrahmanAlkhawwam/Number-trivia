import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

import '../entities/number_trivia.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  GetRandomNumberTrivia({required this.repository});

  final NumberTriviaRepository repository;

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
