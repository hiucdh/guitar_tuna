import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../domain/repositories/audio_repository.dart';
import '../../services/audio/audio_service.dart';
import '../../services/permission/permission_service.dart';

/// Implementation of AudioRepository
class AudioRepositoryImpl implements AudioRepository {
  final AudioService _audioService;
  final PermissionService _permissionService;

  AudioRepositoryImpl(this._audioService, this._permissionService);

  @override
  Future<Either<Failure, Stream<double>>> startPitchDetection() async {
    try {
      await _audioService.start();
      return Right(_audioService.pitchStream);
    } catch (e) {
      return Left(AudioFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> stopPitchDetection() async {
    try {
      await _audioService.stop();
      return const Right(null);
    } catch (e) {
      return Left(AudioFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkMicrophonePermission() async {
    try {
      final result = await _permissionService.checkMicrophonePermission();
      return Right(result);
    } catch (e) {
      return Left(PermissionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> requestMicrophonePermission() async {
    try {
      final result = await _permissionService.requestMicrophonePermission();
      return Right(result);
    } catch (e) {
      return Left(PermissionFailure(e.toString()));
    }
  }
}
