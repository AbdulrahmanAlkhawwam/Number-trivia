import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../../core/util/input_converter.dart';

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
        super(Empty()) {
    on<RandomNumberEvent>(_getTriviaForRandomNumber);
    on<ConcreteNumberEvent>(_getTriviaForConcreteNumber);
  }

  Future<void> _getTriviaForRandomNumber(
      RandomNumberEvent event, Emitter<NumberTriviaState> emit) async {
    emit(Loading());
    final response = await _getRandomNumberTrivia!(const NoParams());

    response.fold(
      (failure) => emit(Error(message: failure.message)),
      (trivia) => emit(Loaded(trivia: trivia)),
    );
  }

  FutureOr<void> _getTriviaForConcreteNumber(
      ConcreteNumberEvent event, Emitter<NumberTriviaState> emit) async {
    emit(Loading());
    final inputEither = input?.strToInt(event.numberString);
    await inputEither!
        .fold((failure) async => emit(Error(message: failure.message)),
            (integer) async {
      final response =
          await _getConcreteNumberTrivia!(NumberTriviaParams(number: integer));

      response.fold(
        (failure) => emit(Error(message: failure.message)),
        (trivia) => emit(Loaded(trivia: trivia)),
      );
    });
  }
}
