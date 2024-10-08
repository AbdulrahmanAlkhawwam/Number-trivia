import 'package:dartz/dartz.dart';

import '../models/number_trivia_model.dart';
import '../data_sources/remote_data_source.dart';
import '../data_sources/local_data_source.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/number_trivia_repository.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/error/failures.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async =>
      await _getTrivia(() => remoteDataSource.getConcreteNumberTrivia(number));

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async =>
      await _getTrivia(() => remoteDataSource.getRandomNumberTrivia());

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    Future<NumberTrivia> Function() getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(
          NumberTriviaModel(
              text: remoteTrivia.text, number: remoteTrivia.number),
        );
        return Right(remoteTrivia);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } catch (e) {
        return Left(CacheFailure(e.toString()));
      }
    }
  }
}
