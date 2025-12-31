import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';

/// Repository interface for audio operations
abstract class AudioRepository {
  /// Starts pitch detection
  Future<Either<Failure, Stream<double>>> startPitchDetection();

  /// Stops pitch detection
  Future<Either<Failure, void>> stopPitchDetection();

  /// Checks microphone permission
  Future<Either<Failure, bool>> checkMicrophonePermission();

  /// Requests microphone permission
  Future<Either<Failure, bool>> requestMicrophonePermission();
}
