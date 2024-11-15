// lib/core/error/failures.dart

import 'package:equatable/equatable.dart';

/// Abstract class representing a failure.
abstract class Failure extends Equatable {
  final List properties;

  const Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object?> get props => [properties];
}

/// Represents a server-side failure.
class ServerFailure extends Failure {}

/// Represents a cache-related failure.
class CacheFailure extends Failure {}

/// Represents a network-related failure.
class NetworkFailure extends Failure {}
