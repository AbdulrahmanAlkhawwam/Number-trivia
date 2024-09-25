import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/models/number_trivia_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class RemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class RemoteDataSourceImpl extends RemoteDataSource {
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      _getTriviaFromUrl(
        "http://numbersapi.com/$number?json",
      );

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() => _getTriviaFromUrl(
        "http://numbersapi.com/random/trivia?json",
      );

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.statusCode == 200
        ? NumberTriviaModel.fromJson(json.decode(response.body))
        : throw ServerException('you are not connected');
  }
}
