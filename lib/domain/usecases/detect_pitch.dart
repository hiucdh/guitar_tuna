import 'package:dartz/dartz.dart';
import '../repositories/audio_repository.dart';
import '../../core/errors/failures.dart';

/// Use case for pitch detection
/// TODO: Implement full pitch detection logic with FFT
class DetectPitch {
  final AudioRepository repository;

  DetectPitch(this.repository);

  Future<Either<Failure, Stream<double>>> execute() {
    return repository.startPitchDetection();
  }

  Future<Either<Failure, void>> stop() {
    return repository.stopPitchDetection();
  }
}
