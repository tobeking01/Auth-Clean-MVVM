// lib/features/authentication/data/datasources/authentication_local_data_source_impl.dart

import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auth_clean_mvvm/core/error/exceptions.dart';
import 'authentication_local_data_source.dart';
import '../models/user_model.dart';

/// Implementation of [AuthenticationLocalDataSource] using SharedPreferences.
class AuthenticationLocalDataSourceImpl implements AuthenticationLocalDataSource {
  final SharedPreferences sharedPreferences;
  final Logger logger = Logger();
  AuthenticationLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel userToCache) {
    final userJson = jsonEncode(userToCache.toJson());
    logger.i('Caching user: $userJson');
    return sharedPreferences.setString('CACHED_USER', userJson);
  }

@override
Future<UserModel> getLastUser() {
  final jsonString = sharedPreferences.getString('CACHED_USER');
  if (jsonString != null) {
    try {
      return Future.value(UserModel.fromJson(jsonDecode(jsonString)));
      
    } catch (e) {
      logger.e('Failed to parse user data: $e');
      throw CacheException();
    }
  } else {
    logger.w('No cached user data found.');
    throw CacheException();
  }
}

Future<void> clearUser() async {
  await sharedPreferences.remove('CACHED_USER');
}

}
