import 'dart:convert';

import 'package:number_trivia/features/core/error/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

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
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
