import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:number_trivia/features/core/network/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/core/util/input_converter.dart';
import '../../features/number_trivia/data/data_sources/remote_data_source.dart';
import '../../features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import '../../features/number_trivia/domain/repositories/number_trivia_repository.dart';
import '../../features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import '../../features/number_trivia/data/data_sources/local_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Number Trivia
  sl.registerFactory(() => NumberTriviaBloc(
        sl(),
        concrete: sl(),
        random: sl(),
        inputConverter: sl(),
      ));

  /// UseCases
  sl.registerLazySingleton(
    () => GetTriviaForConcreteNumber(sl()),
  );
  sl.registerLazySingleton(
    () => GetTriviaForRandomNumber(),
  );

  /// Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
            remoteDataSource: sl(),
            localDataSource: sl(),
            networkInfo: sl(),
          ));

  /// DataSource
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  // Core
  sl.registerLazySingleton(
    () => InputConverter(),
  );
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
