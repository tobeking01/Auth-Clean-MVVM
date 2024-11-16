import '../models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  /// Calls the login endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> login(String email, String password);

  /// Calls the signup endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> signup(String email, String password, String name);
}
