import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/number_trivia_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class LocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaToCache);
}

class LocalDataSourceImpl implements LocalDataSource {
  LocalDataSourceImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString("CACHED_NUMBER_TRIVIA");
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaToCache) {
    return sharedPreferences.setString(
      "CACHED_NUMBER_TRIVIA",
      json.encode(
        numberTriviaToCache.toJson(),
      ),
    );
  }
}
