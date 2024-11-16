import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/authentication_repository.dart';
import '../../../../core/error/failures.dart';

/// Use case for logging in a user.
class LoginUser {
  final AuthenticationRepository repository;

  LoginUser(this.repository);

  /// Executes the login use case.
  /// 
  /// Takes [LoginParams] containing the email and password.
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

/// Parameters for the [LoginUser] use case.
class LoginParams {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});
}
