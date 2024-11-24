import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../../authentication/domain/usecases/logout_user.dart';

/// AppBar Events
abstract class AppBarEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LogoutEvent extends AppBarEvent {}

/// AppBar States
abstract class AppBarState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppBarInitial extends AppBarState {}

class LogoutLoading extends AppBarState {}

class LogoutSuccess extends AppBarState {}

class LogoutFailureState extends AppBarState {
  final String message;

  LogoutFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

/// Bloc for handling AppBar logic
class AppBarBloc extends Bloc<AppBarEvent, AppBarState> {
  final LogoutUser logoutUseCase;

  AppBarBloc({required this.logoutUseCase}) : super(AppBarInitial()) {
    on<LogoutEvent>(_onLogoutEvent);
  }

  Future<void> _onLogoutEvent(
    LogoutEvent event,
    Emitter<AppBarState> emit,
  ) async {
    emit(LogoutLoading());
    final result = await logoutUseCase();

    result.fold(
      (failure) => emit(LogoutFailureState(_mapFailureToMessage(failure))),
      (_) => emit(LogoutSuccess()),
    );
  }

  /// Maps a [Failure] to a user-friendly error message.
  String _mapFailureToMessage(Failure failure) {
    return failure.message;
  }
}
