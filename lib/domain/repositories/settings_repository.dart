import 'package:dartz/dartz.dart';
import '../entities/settings.dart';
import '../../core/errors/failures.dart';

/// Repository interface for settings operations
abstract class SettingsRepository {
  /// Gets current settings
  Future<Either<Failure, Settings>> getSettings();

  /// Saves settings
  Future<Either<Failure, void>> saveSettings(Settings settings);

  /// Resets settings to default
  Future<Either<Failure, void>> resetSettings();
}
