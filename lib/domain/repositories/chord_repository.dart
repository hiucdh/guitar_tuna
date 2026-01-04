import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/chord.dart';

abstract class ChordRepository {
  Future<Either<Failure, List<Chord>>> getChords();
  Future<Either<Failure, Chord>> getChordById(String id);
}
