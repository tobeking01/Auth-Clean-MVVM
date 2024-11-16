import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Provides utilities for converting and validating user input.
class InputConverter {
  /// Converts a string input to an integer.
  /// Returns a [Right<int>] if the input is a valid integer.
  /// Returns a [Left<Failure>] if the input is invalid.
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);

      if (integer < 0) {
        return Left(const InvalidInputFailure());
      }

      return Right(integer);
    } catch (e) {
      return Left(const InvalidInputFailure());
    }
  }
}

/// Represents a failure due to invalid input.
class InvalidInputFailure extends Failure {
  /// Constructor initializes the failure with a default property.
  const InvalidInputFailure() : super(properties: const ['Invalid input']);
}
