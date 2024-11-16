import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/entities/user.dart';

final logger = Logger();

/// Authentication events handled by [AuthenticationBloc].
abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event triggered to log in a user.
class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// Authentication states managed by [AuthenticationBloc].
abstract class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Initial state of the authentication.
class AuthenticationInitial extends AuthenticationState {}

/// State representing a loading state during authentication.
class AuthenticationLoading extends AuthenticationState {}

/// State representing a successful login.
class AuthenticationSuccess extends AuthenticationState {
  final User user;

  AuthenticationSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

/// State representing a failed authentication.
class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Business logic component for handling authentication.
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUser loginUser;

  AuthenticationBloc({required this.loginUser})
      : super(AuthenticationInitial()) {
    on<LoginEvent>(_onLoginEvent);
  }

  /// Handles the [LoginEvent] to authenticate a user.
  Future<void> _onLoginEvent(
    LoginEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());

    try {
      final result = await loginUser(
        LoginParams(email: event.email, password: event.password),
      );

      result.fold(
        (failure) {
          final errorMessage = _mapFailureToMessage(failure);
          logger.e('❌ Login failed: $errorMessage');
          emit(AuthenticationFailure(errorMessage));
        },
        (user) {
          logger.i('✅ Login successful for user: ${user.toString()}');
          emit(AuthenticationSuccess(user));
        },
      );
    } catch (e) {
      logger.e('❌ Error during login: $e');
      emit(AuthenticationFailure('Unexpected error occurred. Please try again.'));
    }
  }

  /// Maps a [Failure] to a user-friendly error message.
  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server error occurred. Please try again.';
    } else if (failure is NetworkFailure) {
      return 'No internet connection. Please check your network.';
    } else if (failure is CacheFailure) {
      return 'Failed to fetch cached data. Please try again.';
    } else {
      return 'Unexpected error occurred. Please try again.';
    }
  }
}
