part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState {
  const NumberTriviaState();
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;

  const Loaded({required this.trivia});
}

class Error extends NumberTriviaState {
  final String message;

  const Error({required this.message});
}
