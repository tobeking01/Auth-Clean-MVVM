import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/logout_repository.dart';

class LogoutUser {
  final LogoutRepository repository;

  LogoutUser(this.repository);

  Future<Either<Failure, void>> call() async {
    try {
      return await repository.logout();
    } catch (e) {
      return Left(LogoutFailure(message: 'Failed to log out.'));
    }
  }
}
