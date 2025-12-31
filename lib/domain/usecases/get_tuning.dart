import 'package:dartz/dartz.dart';
import '../repositories/tuning_repository.dart';
import '../entities/tuning.dart';
import '../../core/errors/failures.dart';

/// Use case for getting a tuning by ID
class GetTuning {
  final TuningRepository repository;

  GetTuning(this.repository);

  Future<Either<Failure, Tuning>> execute(String id) {
    return repository.getTuningById(id);
  }

  Future<Either<Failure, List<Tuning>>> getAllTunings() {
    return repository.getAllTunings();
  }
}
