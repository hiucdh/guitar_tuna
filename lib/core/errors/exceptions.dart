/// Custom exceptions for the app
library;

/// Base exception class
abstract class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, [this.code]);

  @override
  String toString() => code != null ? '[$code] $message' : message;
}

// ============================================================
// AUDIO EXCEPTIONS
// ============================================================

/// Exception thrown when audio initialization fails
class AudioInitializationException extends AppException {
  const AudioInitializationException([String? message])
    : super(message ?? 'Failed to initialize audio system', 'AUDIO_INIT');
}

/// Exception thrown when pitch detection fails
class PitchDetectionException extends AppException {
  const PitchDetectionException([String? message])
    : super(message ?? 'Failed to detect pitch', 'PITCH_DETECTION');
}

/// Exception thrown for general audio errors
class AudioException extends AppException {
  const AudioException(super.message, [super.code = 'AUDIO_ERROR']);
}

// ============================================================
// PERMISSION EXCEPTIONS
// ============================================================

/// Exception thrown when permission is denied
class PermissionDeniedException extends AppException {
  const PermissionDeniedException([String? message])
    : super(message ?? 'Required permission was denied', 'PERMISSION_DENIED');
}

/// Exception thrown when permission is permanently denied
class PermissionPermanentlyDeniedException extends AppException {
  const PermissionPermanentlyDeniedException([String? message])
    : super(
        message ?? 'Permission permanently denied',
        'PERMISSION_PERMANENTLY_DENIED',
      );
}

// ============================================================
// STORAGE EXCEPTIONS
// ============================================================

/// Exception thrown when storage operation fails
class StorageException extends AppException {
  const StorageException(super.message, [super.code = 'STORAGE_ERROR']);
}

/// Exception thrown when data cannot be read
class DataReadException extends StorageException {
  const DataReadException([String? message])
    : super(message ?? 'Failed to read data', 'DATA_READ');
}

/// Exception thrown when data cannot be written
class DataWriteException extends StorageException {
  const DataWriteException([String? message])
    : super(message ?? 'Failed to write data', 'DATA_WRITE');
}

// ============================================================
// VALIDATION EXCEPTIONS
// ============================================================

/// Exception thrown when validation fails
class ValidationException extends AppException {
  const ValidationException(super.message, [super.code = 'VALIDATION_ERROR']);
}

/// Exception thrown when input is invalid
class InvalidInputException extends ValidationException {
  const InvalidInputException([String? message])
    : super(message ?? 'Invalid input', 'INVALID_INPUT');
}

// ============================================================
// NETWORK EXCEPTIONS (for future use)
// ============================================================

/// Exception thrown for network errors
class NetworkException extends AppException {
  const NetworkException(super.message, [super.code = 'NETWORK_ERROR']);
}

/// Exception thrown when no internet connection
class NoInternetException extends NetworkException {
  const NoInternetException([String? message])
    : super(message ?? 'No internet connection', 'NO_INTERNET');
}

// ============================================================
// GENERAL EXCEPTIONS
// ============================================================

/// Exception thrown for unexpected errors
class UnexpectedException extends AppException {
  const UnexpectedException([String? message])
    : super(message ?? 'An unexpected error occurred', 'UNEXPECTED');
}

/// Exception thrown when a feature is not implemented
class NotImplementedException extends AppException {
  const NotImplementedException([String? message])
    : super(message ?? 'Feature not implemented', 'NOT_IMPLEMENTED');
}
