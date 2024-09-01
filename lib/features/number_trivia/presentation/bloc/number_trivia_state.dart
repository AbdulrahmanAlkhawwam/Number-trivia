part of 'number_trivia_bloc.dart';

sealed class NumberTriviaState extends Equatable {
  const NumberTriviaState();
}

class Empty extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class Loading extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class Loaded extends NumberTriviaState {
  const Loaded({required this.trivia});

  final NumberTrivia trivia;

  @override
  List<Object> get props => [trivia];
}

class Error extends NumberTriviaState {
  const Error({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
