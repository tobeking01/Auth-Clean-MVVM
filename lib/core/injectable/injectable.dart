import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../features/authentication/data/repositories/logout_repository_impl.dart';
import '../../features/authentication/domain/repositories/logout_repository.dart';
import '../../features/authentication/domain/usecases/logout_user.dart';
import '../../features/authentication/presentation/blocs/authentication_bloc.dart';
import '../network/network_info.dart';
import '../network/network_info_impl.dart';
import '../../features/authentication/data/datasources/authentication_remote_data_source.dart';
import '../../features/authentication/data/datasources/authentication_remote_data_source_impl.dart';
import '../../features/authentication/data/datasources/authentication_local_data_source.dart';
import '../../features/authentication/data/datasources/authentication_local_data_source_impl.dart';
import '../../features/authentication/data/repositories/authentication_repository_impl.dart';
import '../../features/authentication/domain/repositories/authentication_repository.dart';
import '../../features/home/presentation/bloc/appbar_bloc.dart';
import '../../features/home/presentation/bloc/bottom_bloc.dart';

final GetIt getIt = GetIt.instance;

/// Initializes all the necessary dependencies.
Future<void> setupDependencies() async {
  try {
    // External Dependencies
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton(() => Connectivity());
    getIt.registerLazySingleton(() => sharedPreferences);
    getIt.registerLazySingleton<http.Client>(() => http.Client());

    // Core Dependencies
    getIt.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(getIt<Connectivity>()));

    // Authentication Dependencies
    getIt.registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSourceImpl(client: getIt<http.Client>()));
    getIt.registerLazySingleton<AuthenticationLocalDataSource>(
        () => AuthenticationLocalDataSourceImpl(
            sharedPreferences: getIt<SharedPreferences>()));
    getIt.registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(
              remoteDataSource: getIt<AuthenticationRemoteDataSource>(),
              localDataSource: getIt<AuthenticationLocalDataSource>(),
              networkInfo: getIt<NetworkInfo>(),
            ));

    // AppBar Dependencies
    getIt.registerLazySingleton<LogoutRepository>(
        () => LogoutRepositoryImpl(networkInfo: getIt<NetworkInfo>()));
    getIt.registerLazySingleton(() => LogoutUser(getIt<LogoutRepository>()));
    getIt.registerFactory(
        () => AppBarBloc(logoutUseCase: getIt<LogoutUser>()));

    // Navigation Dependencies
    getIt.registerFactory(() => BottomBloc());
  } catch (e) {
     logger.i('❌ Failed to initialize dependencies: $e');
    throw Exception('Failed to initialize dependencies: $e');
  }
}
