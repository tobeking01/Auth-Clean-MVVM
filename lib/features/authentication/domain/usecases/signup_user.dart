import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/authentication_repository.dart';
import '../../../../core/error/failures.dart';

class SignupUser {
  final AuthenticationRepository repository;

  SignupUser(this.repository);

  Future<Either<Failure, User>> call(String email, String password, String name) async {
    return await repository.signup(email, password, name);
  }
}
