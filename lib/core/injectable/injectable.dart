// lib/core/injection/injection.dart

import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:auth_clean_mvvm/core/network/network_info.dart';
import 'package:auth_clean_mvvm/core/network/network_info_impl.dart';
import 'package:auth_clean_mvvm/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:auth_clean_mvvm/features/authentication/data/datasources/authentication_remote_data_source_impl.dart';
import 'package:auth_clean_mvvm/features/authentication/data/datasources/authentication_local_data_source.dart';
import 'package:auth_clean_mvvm/features/authentication/data/datasources/authentication_local_data_source_impl.dart';
import 'package:auth_clean_mvvm/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:auth_clean_mvvm/features/authentication/domain/repositories/authentication_repository.dart';

final GetIt getIt = GetIt.instance;

/// Initializes all the necessary dependencies.
Future<void> setupDependencies() async {
  try {
    // External dependencies
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton(() => Connectivity());
    getIt.registerLazySingleton(() => sharedPreferences);
    getIt.registerLazySingleton<http.Client>(() => http.Client());

    // Core
    getIt.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(getIt<Connectivity>()));

    // Data sources
    getIt.registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSourceImpl(client: getIt<http.Client>()));
    getIt.registerLazySingleton<AuthenticationLocalDataSource>(() =>
        AuthenticationLocalDataSourceImpl(
            sharedPreferences: getIt<SharedPreferences>()));

    // Repositories
    getIt.registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(
              remoteDataSource: getIt<AuthenticationRemoteDataSource>(),
              localDataSource: getIt<AuthenticationLocalDataSource>(),
              networkInfo: getIt<NetworkInfo>(),
            ));
  } catch (e) {
    throw Exception('Failed to initialize dependencies: $e');
  }
}
