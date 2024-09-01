part of 'number_trivia_bloc.dart';

@immutable
sealed class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  const GetTriviaForConcreteNumber(this.numberString);

  final String numberString;

  @override
  List<Object?> get props => [numberString];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {
  @override
  List<Object> get props => [];
}
