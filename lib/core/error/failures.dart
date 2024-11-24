import 'package:equatable/equatable.dart';

/// Abstract class representing a failure in the application.
abstract class Failure extends Equatable {
  /// A message describing the failure (optional).
  final String message;

  /// Constructor to initialize failure with optional message.
  const Failure({this.message = 'An unknown error occurred.'});

  @override
  List<Object?> get props => [message];
}

/// Represents a failure due to server-side issues.
class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Server error occurred.'});
}

/// Represents a failure related to caching issues.
class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache error occurred.'});
}

/// Represents a failure due to network issues.
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'Network error occurred.'});
}

/// Represents a failure related to logout functionality.
class LogoutFailure extends Failure {
  const LogoutFailure({required super.message});
}
