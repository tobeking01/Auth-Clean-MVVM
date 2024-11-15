import '../models/user_model.dart';

abstract class AuthenticationLocalDataSource {
  /// Gets the cached [UserModel] which was gotten the last time the user was logged in.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<UserModel> getLastUser();

  /// Caches the [UserModel] locally.
  Future<void> cacheUser(UserModel userToCache);
}

// TODO: Implement the local data source using shared_preferences or hive.
