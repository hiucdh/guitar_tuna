import 'package:dartz/dartz.dart';
import '../repositories/settings_repository.dart';
import '../entities/settings.dart';
import '../../core/errors/failures.dart';

/// Use case for saving app settings
class SaveSettings {
  final SettingsRepository repository;

  SaveSettings(this.repository);

  Future<Either<Failure, void>> execute(Settings settings) {
    return repository.saveSettings(settings);
  }
}
