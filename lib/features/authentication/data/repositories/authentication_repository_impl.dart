import 'package:auth_clean_mvvm/core/error/exceptions.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../datasources/authentication_remote_data_source.dart';
import '../datasources/authentication_local_data_source.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;
  final AuthenticationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        // Attempt remote login
        final userModel = await remoteDataSource.login(email, password);
        
        // Cache the user data locally
        await localDataSource.cacheUser(userModel);
        return Right(userModel);
      } on ServerException {
        // Handle server-related failures
        return Left(ServerFailure());
      }
    } else {
      try {
        // Fallback to local cache if offline
        final userModel = await localDataSource.getLastUser();
        return Right(userModel);
      } on CacheException {
        // Handle cache-related failures
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, User>> signup(String email, String password, String username) async {
    if (await networkInfo.isConnected) {
      try {
        // Attempt remote signup
        final userModel = await remoteDataSource.signup(username, email, password);
        
        // Cache the user data locally
        await localDataSource.cacheUser(userModel);
        return Right(userModel);
      } on ServerException {
        // Handle server-related failures
        return Left(ServerFailure());
      }
    } else {
      // Cannot signup while offline
      return Left(NetworkFailure());
    }
  }
}
