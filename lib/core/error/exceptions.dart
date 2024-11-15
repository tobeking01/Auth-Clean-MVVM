// lib/core/error/exceptions.dart

/// Base class for all exceptions.
abstract class AppException implements Exception {
  final String message;

  AppException([this.message = 'An unknown error occurred.']);

  @override
  String toString() => message;
}

/// Represents a server-side exception.
class ServerException extends AppException {
  ServerException([super.message = 'Server Exception']);
}

/// Represents a cache-related exception.
class CacheException extends AppException {
  CacheException([super.message = 'Cache Exception']);
}

/// Represents a network-related exception.
class NetworkException extends AppException {
  NetworkException([super.message = 'Network Exception']);
}
