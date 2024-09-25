part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaEvent {}

class ConcreteNumberEvent extends NumberTriviaEvent {
  final String numberString;

  ConcreteNumberEvent(this.numberString);
}

class RandomNumberEvent extends NumberTriviaEvent {}
