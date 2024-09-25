import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/number_trivia_model.dart';
import '../../../../core/error/exceptions.dart';

const String numberTrivia = "CACHED_NUMBER_TRIVIA";

abstract class LocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaToCache);
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(numberTrivia);
    if (jsonString != null) {
      return Future.value(
        NumberTriviaModel.fromJson(
          json.decode(jsonString),
        ),
      );
    } else {
      throw CacheException('There are no data saved');
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaToCache) {
    return sharedPreferences.setString(
      numberTrivia,
      json.encode(
        numberTriviaToCache.toJson(),
      ),
    );
  }
}
