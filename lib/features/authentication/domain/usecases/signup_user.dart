import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/authentication_repository.dart';
import '../../../../core/error/failures.dart';

/// Use case for signing up a new user.
class SignupUser {
  final AuthenticationRepository repository;

  SignupUser(this.repository);

  /// Executes the signup use case.
  /// 
  /// Takes [SignupParams] containing the email, password, and name.
  Future<Either<Failure, User>> call(SignupParams params) async {
    return await repository.signup(params.email, params.password, params.username);
  }
}

/// Parameters for the [SignupUser] use case.
class SignupParams {
  final String email;
  final String password;
  final String username;

  const SignupParams({
    required this.email,
    required this.password,
    required this.username,
  });
}
