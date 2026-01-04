import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/chord.dart';
import '../repositories/chord_repository.dart';

class GetChords {
  final ChordRepository repository;

  GetChords(this.repository);

  Future<Either<Failure, List<Chord>>> execute() {
    return repository.getChords();
  }
}
