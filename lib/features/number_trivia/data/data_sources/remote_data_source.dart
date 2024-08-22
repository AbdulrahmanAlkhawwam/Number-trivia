import 'dart:convert';

import 'package:tdd_cac1/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class RemoteDataSourceImpl extends RemoteDataSource {
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    final url = Uri.parse('http://numbersapi.com/$number?json');
    final response = await http.get(url);
    final trivia = await json.decode(response.body);
    return NumberTriviaModel(text: trivia['text'], number: trivia['number']);
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}
