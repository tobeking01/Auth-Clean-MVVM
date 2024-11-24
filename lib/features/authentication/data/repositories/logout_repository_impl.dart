import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/logout_repository.dart';

class LogoutRepositoryImpl implements LogoutRepository {
  final NetworkInfo networkInfo;

  LogoutRepositoryImpl({required this.networkInfo});

  @override
  Future<Either<Failure, void>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        await _remoteLogout(); // Simulates API logout
        await _clearLocalData(); // Clears cached data
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure(message: 'Failed to log out from server.'));
      } catch (e) {
        return Left(LogoutFailure(message: 'Unexpected error: $e'));
      }
    } else {
      try {
        await _clearLocalData(); // Clear cached data in offline mode
        return const Right(null);
      } on CacheException {
        return Left(CacheFailure(message: 'Failed to clear local data.'));
      }
    }
  }

  Future<void> _remoteLogout() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> _clearLocalData() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
