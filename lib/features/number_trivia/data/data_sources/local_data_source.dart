import '../../domain/entities/number_trivia.dart';
import '../models/number_trivia_model.dart';

abstract class LocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaToCache);
}
