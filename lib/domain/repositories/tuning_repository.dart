import 'package:dartz/dartz.dart';
import '../entities/tuning.dart';
import '../../core/errors/failures.dart';

/// Repository interface for tuning operations
abstract class TuningRepository {
  /// Gets all available tunings
  Future<Either<Failure, List<Tuning>>> getAllTunings();

  /// Gets a tuning by ID
  Future<Either<Failure, Tuning>> getTuningById(String id);

  /// Saves a custom tuning
  Future<Either<Failure, void>> saveCustomTuning(Tuning tuning);

  /// Deletes a custom tuning
  Future<Either<Failure, void>> deleteCustomTuning(String id);
}
