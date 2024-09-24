import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/util/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia? _getConcreteNumberTrivia;
  final GetRandomNumberTrivia? _getRandomNumberTrivia;
  final InputConverter? input;

  NumberTriviaBloc({
    required GetConcreteNumberTrivia concrete,
    required GetRandomNumberTrivia random,
    required this.input,
  })  : assert(input != null),
        _getConcreteNumberTrivia = concrete,
        _getRandomNumberTrivia = random,
        super(
          Empty(),
        ) {
    on<GetTriviaForRandomNumber>(_getTriviaForRandomNumber);
    on<GetTriviaForConcreteNumber>(_getTriviaForConcreteNumber);
  }

  FutureOr<void> _getTriviaForRandomNumber(
      GetTriviaForRandomNumber event, Emitter<NumberTriviaState> emit) async {
    emit(Loading());
    final failureOrTrivia = await _getRandomNumberTrivia!(const NoParams());

    failureOrTrivia.fold(
      (failure) => emit(Error(message: _mapFailureToMessage(failure))),
      (trivia) => emit(Loaded(trivia: trivia)),
    );
  }

  FutureOr<void> _getTriviaForConcreteNumber(
      GetTriviaForConcreteNumber event, Emitter<NumberTriviaState> emit) async {
    emit(Loading());
    final inputEither = input?.stringToUnsignedInteger(event.numberString);
    await inputEither!.fold(
        (failure) async => emit(
              const Error(
                message:
                    "Invalid Input - The number must be a positive integer or zero!",
              ),
            ), (integer) async {
      final failureOrTrivia =
          await _getConcreteNumberTrivia!(NumberTriviaParams(number: integer));

      failureOrTrivia.fold(
        (failure) => emit(Error(message: _mapFailureToMessage(failure))),
        (trivia) => emit(Loaded(trivia: trivia)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return "Server Failure";
      case const (CacheFailure):
        return "Cache Failure";
      default:
        return "Unexpected error";
    }
  }
}
