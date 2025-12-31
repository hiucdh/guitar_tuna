import 'package:dartz/dartz.dart';
import '../repositories/settings_repository.dart';
import '../entities/settings.dart';
import '../../core/errors/failures.dart';

/// Use case for getting app settings
class GetSettings {
  final SettingsRepository repository;

  GetSettings(this.repository);

  Future<Either<Failure, Settings>> execute() {
    return repository.getSettings();
  }
}
