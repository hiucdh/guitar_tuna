import 'package:equatable/equatable.dart';

/// Base failure class for error handling
/// Using Either&lt;Failure, Success&gt; pattern
abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure(this.message, [this.code]);

  @override
  List<Object?> get props => [message, code];

  @override
  String toString() => code != null ? '[$code] $message' : message;
}

// ============================================================
// AUDIO FAILURES
// ============================================================

/// Failure for audio-related errors
class AudioFailure extends Failure {
  const AudioFailure(super.message, [super.code = 'AUDIO_FAILURE']);
}

/// Failure when pitch detection fails
class PitchDetectionFailure extends AudioFailure {
  const PitchDetectionFailure([String? message])
    : super(message ?? 'Failed to detect pitch', 'PITCH_DETECTION_FAILURE');
}

// ============================================================
// PERMISSION FAILURES
// ============================================================

/// Failure for permission-related errors
class PermissionFailure extends Failure {
  const PermissionFailure(super.message, [super.code = 'PERMISSION_FAILURE']);
}

// ============================================================
// STORAGE FAILURES
// ============================================================

/// Failure for storage-related errors
class StorageFailure extends Failure {
  const StorageFailure(super.message, [super.code = 'STORAGE_FAILURE']);
}

/// Failure when cache operation fails
class CacheFailure extends StorageFailure {
  const CacheFailure([String? message])
    : super(message ?? 'Cache operation failed', 'CACHE_FAILURE');
}

// ============================================================
// VALIDATION FAILURES
// ============================================================

/// Failure for validation errors
class ValidationFailure extends Failure {
  const ValidationFailure(super.message, [super.code = 'VALIDATION_FAILURE']);
}

// ============================================================
// NETWORK FAILURES (for future use)
// ============================================================

/// Failure for network-related errors
class NetworkFailure extends Failure {
  const NetworkFailure(super.message, [super.code = 'NETWORK_FAILURE']);
}

/// Failure when server returns an error
class ServerFailure extends NetworkFailure {
  const ServerFailure([String? message])
    : super(message ?? 'Server error', 'SERVER_FAILURE');
}

// ============================================================
// GENERAL FAILURES
// ============================================================

/// Failure for unexpected errors
class UnexpectedFailure extends Failure {
  const UnexpectedFailure([String? message])
    : super(message ?? 'An unexpected error occurred', 'UNEXPECTED_FAILURE');
}

/// Failure when a feature is not implemented
class NotImplementedFailure extends Failure {
  const NotImplementedFailure([String? message])
    : super(message ?? 'Feature not implemented', 'NOT_IMPLEMENTED');
}
