// lib/core/error/exceptions.dart

/// Base class for all exceptions in the application.
/// Provides a default error message and implements [Exception].
abstract class AppException implements Exception {
  /// Error message associated with the exception.
  final String message;

  /// Constructor with an optional message.
  const AppException([this.message = 'An unknown error occurred.']);

  /// Returns the exception message as a string.
  @override
  String toString() => message;
}

/// Represents a server-side exception, typically for 5xx HTTP errors.
class ServerException extends AppException {
  /// Constructor with an optional message.
  const ServerException([super.message = 'Server Exception']);
}

/// Represents a cache-related exception, such as read/write failures in local storage.
class CacheException extends AppException {
  /// Constructor with an optional message.
  const CacheException([super.message = 'Cache Exception']);
}

/// Represents a network-related exception, such as no internet connection or timeouts.
class NetworkException extends AppException {
  /// Constructor with an optional message.
  const NetworkException([super.message = 'Network Exception']);
}
