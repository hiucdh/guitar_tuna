import 'package:dartz/dartz.dart';
import '../../core/constants/app_constants.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/tuning.dart';
import '../../domain/repositories/tuning_repository.dart';
import '../datasources/local/local_data_source.dart';
import '../models/tuning_model.dart';

/// Implementation of TuningRepository
class TuningRepositoryImpl implements TuningRepository {
  final LocalDataSource localDataSource;

  TuningRepositoryImpl(this.localDataSource);

  /// Predefined tuning presets
  static final List<TuningModel> _presetTunings = [
    // Standard tuning (E A D G B E)
    const TuningModel(
      id: 'standard',
      name: 'Standard',
      notes: ['E', 'A', 'D', 'G', 'B', 'E'],
      frequencies: [82.41, 110.00, 146.83, 196.00, 246.94, 329.63],
      description: 'Standard guitar tuning (E A D G B E)',
    ),

    // Drop D (D A D G B E)
    const TuningModel(
      id: 'drop_d',
      name: 'Drop D',
      notes: ['D', 'A', 'D', 'G', 'B', 'E'],
      frequencies: [73.42, 110.00, 146.83, 196.00, 246.94, 329.63],
      description: 'Drop D tuning - low E string tuned down to D',
    ),

    // Drop C (C G C F A D)
    const TuningModel(
      id: 'drop_c',
      name: 'Drop C',
      notes: ['C', 'G', 'C', 'F', 'A', 'D'],
      frequencies: [65.41, 98.00, 130.81, 174.61, 220.00, 293.66],
      description: 'Drop C tuning - all strings tuned down 2 semitones',
    ),

    // Open G (D G D G B D)
    const TuningModel(
      id: 'open_g',
      name: 'Open G',
      notes: ['D', 'G', 'D', 'G', 'B', 'D'],
      frequencies: [73.42, 98.00, 146.83, 196.00, 246.94, 293.66],
      description: 'Open G tuning - forms a G major chord',
    ),

    // DADGAD
    const TuningModel(
      id: 'dadgad',
      name: 'DADGAD',
      notes: ['D', 'A', 'D', 'G', 'A', 'D'],
      frequencies: [73.42, 110.00, 146.83, 196.00, 220.00, 293.66],
      description: 'DADGAD tuning - popular for Celtic music',
    ),

    // Half Step Down (Eb Ab Db Gb Bb Eb)
    const TuningModel(
      id: 'half_step_down',
      name: 'Half Step Down',
      notes: ['Eb', 'Ab', 'Db', 'Gb', 'Bb', 'Eb'],
      frequencies: [77.78, 103.83, 138.59, 185.00, 233.08, 311.13],
      description: 'All strings tuned down a half step',
    ),

    // Whole Step Down (D G C F A D)
    const TuningModel(
      id: 'whole_step_down',
      name: 'Whole Step Down',
      notes: ['D', 'G', 'C', 'F', 'A', 'D'],
      frequencies: [73.42, 98.00, 130.81, 174.61, 220.00, 293.66],
      description: 'All strings tuned down a whole step',
    ),
  ];

  @override
  Future<Either<Failure, List<Tuning>>> getAllTunings() async {
    try {
      // Get custom tunings from local storage
      final customTuningsJson = await localDataSource.getCustomTunings();
      final customTunings = customTuningsJson
          .map((json) => TuningModel.fromJson(json))
          .toList();

      // Combine preset and custom tunings
      final allTunings = [
        ..._presetTunings.map((model) => model.toEntity()),
        ...customTunings.map((model) => model.toEntity()),
      ];

      return Right(allTunings);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get tunings: $e'));
    }
  }

  @override
  Future<Either<Failure, Tuning>> getTuningById(String id) async {
    try {
      // Check preset tunings first
      final presetTuning = _presetTunings
          .where((tuning) => tuning.id == id)
          .firstOrNull;

      if (presetTuning != null) {
        return Right(presetTuning.toEntity());
      }

      // Check custom tunings
      final customTuningsJson = await localDataSource.getCustomTunings();
      final customTuning = customTuningsJson
          .map((json) => TuningModel.fromJson(json))
          .where((tuning) => tuning.id == id)
          .firstOrNull;

      if (customTuning != null) {
        return Right(customTuning.toEntity());
      }

      return Left(
        StorageFailure('Tuning with id "$id" not found'),
      );
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get tuning: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> saveCustomTuning(Tuning tuning) async {
    try {
      // Get existing custom tunings
      final customTuningsJson = await localDataSource.getCustomTunings();
      final customTunings = customTuningsJson
          .map((json) => TuningModel.fromJson(json))
          .toList();

      // Check if tuning already exists
      final existingIndex = customTunings
          .indexWhere((t) => t.id == tuning.id);

      final tuningModel = TuningModel.fromEntity(tuning);

      if (existingIndex != -1) {
        // Update existing tuning
        customTunings[existingIndex] = tuningModel;
      } else {
        // Add new tuning
        customTunings.add(tuningModel);
      }

      // Check limit
      if (customTunings.length > AppConstants.maxCustomTunings) {
        return Left(
          ValidationFailure(
            'Maximum ${AppConstants.maxCustomTunings} custom tunings allowed',
          ),
        );
      }

      // Save to local storage
      final updatedJson = customTunings.map((t) => t.toJson()).toList();
      await localDataSource.saveCustomTunings(updatedJson);

      return const Right(null);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to save custom tuning: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCustomTuning(String id) async {
    try {
      // Get existing custom tunings
      final customTuningsJson = await localDataSource.getCustomTunings();
      final customTunings = customTuningsJson
          .map((json) => TuningModel.fromJson(json))
          .toList();

      // Remove tuning with matching id
      customTunings.removeWhere((tuning) => tuning.id == id);

      // Save updated list
      final updatedJson = customTunings.map((t) => t.toJson()).toList();
      await localDataSource.saveCustomTunings(updatedJson);

      return const Right(null);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to delete custom tuning: $e'));
    }
  }
}
