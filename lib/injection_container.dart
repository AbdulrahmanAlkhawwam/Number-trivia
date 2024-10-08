import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import './core/util/input_converter.dart';
import './core/network/network_info.dart';
import './features/number_trivia/data/data_sources/remote_data_source.dart';
import './features/number_trivia/data/data_sources/local_data_source.dart';
import './features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import './features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import './features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import './features/number_trivia/domain/repositories/number_trivia_repository.dart';
import './features/number_trivia/data/repositories/number_trivia_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// # Features
  /// Bloc
  sl.registerFactory(
    () => NumberTriviaBloc(
      concrete: sl(),
      input: sl(),
      random: sl(),
    ),
  );

  /// UseCases
  sl.registerLazySingleton(
    () => GetConcreteNumberTrivia(repository: sl()),
  );
  sl.registerLazySingleton(
    () => GetRandomNumberTrivia(repository: sl()),
  );

  /// Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  /// DataSource
  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(),
  );

  /// # Core
  /// Util
  sl.registerLazySingleton(
    () => InputConverter(),
  );

  /// network
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );
  sl.registerLazySingleton(
    () => http.Client(),
  );
  sl.registerLazySingleton(
    () => DataConnectionChecker(),
  );
}
