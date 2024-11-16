// lib/core/error/failures.dart

import 'package:equatable/equatable.dart';

/// Abstract class representing a failure in the application.
/// All failures should extend this class.
abstract class Failure extends Equatable {
  /// A list of properties associated with the failure.
  final List<dynamic> properties;

  /// Constructor to initialize failure with optional properties.
  const Failure({this.properties = const <dynamic>[]});

  @override
  List<Object?> get props => [properties];
}

/// Represents a failure due to server-side issues, such as 500 errors or unavailable services.
class ServerFailure extends Failure {
  /// Constructor using super parameters to initialize properties.
  const ServerFailure({super.properties});
}

/// Represents a failure related to caching issues, such as reading or writing to local storage.
class CacheFailure extends Failure {
  /// Constructor using super parameters to initialize properties.
  const CacheFailure({super.properties});
}

/// Represents a failure due to network issues, such as no connectivity or timeouts.
class NetworkFailure extends Failure {
  /// Constructor using super parameters to initialize properties.
  const NetworkFailure({super.properties});
}
