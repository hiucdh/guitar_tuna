import 'package:flutter/material.dart';
import '../../domain/entities/settings.dart';
import '../../domain/usecases/get_settings.dart';
import '../../domain/usecases/save_settings.dart';
import '../../core/utils/logger.dart';

/// Provider for managing app settings
class SettingsProvider extends ChangeNotifier {
  final GetSettings getSettings;
  final SaveSettings saveSettings;

  Settings _settings = const Settings();
  bool _isLoading = false;
  String? _error;

  SettingsProvider({required this.getSettings, required this.saveSettings});

  // Getters
  Settings get settings => _settings;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Individual setting getters
  String get tuningId => _settings.tuningId;
  double get referencePitch => _settings.referencePitch;
  String get themeMode => _settings.themeMode;
  double get sensitivity => _settings.sensitivity;
  bool get autoMode => _settings.autoMode;
  bool get showFrequency => _settings.showFrequency;
  bool get showCents => _settings.showCents;
  bool get vibrationEnabled => _settings.vibrationEnabled;
  bool get soundEnabled => _settings.soundEnabled;

  /// Loads settings from repository
  Future<void> loadSettings() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await getSettings.execute();

    result.fold(
      (failure) {
        _error = failure.message;
        Logger.error('Failed to load settings', error: failure);
      },
      (loadedSettings) {
        _settings = loadedSettings;
        Logger.success('Settings loaded successfully');
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  /// Updates settings
  Future<void> updateSettings(Settings newSettings) async {
    final result = await saveSettings.execute(newSettings);

    result.fold(
      (failure) {
        _error = failure.message;
        Logger.error('Failed to save settings', error: failure);
      },
      (_) {
        _settings = newSettings;
        Logger.success('Settings saved successfully');
      },
    );

    notifyListeners();
  }

  /// Updates tuning ID
  Future<void> updateTuningId(String tuningId) async {
    await updateSettings(_settings.copyWith(tuningId: tuningId));
  }

  /// Updates reference pitch
  Future<void> updateReferencePitch(double pitch) async {
    await updateSettings(_settings.copyWith(referencePitch: pitch));
  }

  /// Updates theme mode
  Future<void> updateThemeMode(String mode) async {
    await updateSettings(_settings.copyWith(themeMode: mode));
  }

  /// Updates sensitivity
  Future<void> updateSensitivity(double sensitivity) async {
    await updateSettings(_settings.copyWith(sensitivity: sensitivity));
  }

  /// Toggles auto mode
  Future<void> toggleAutoMode() async {
    await updateSettings(_settings.copyWith(autoMode: !_settings.autoMode));
  }

  /// Toggles show frequency
  Future<void> toggleShowFrequency() async {
    await updateSettings(
      _settings.copyWith(showFrequency: !_settings.showFrequency),
    );
  }

  /// Toggles show cents
  Future<void> toggleShowCents() async {
    await updateSettings(_settings.copyWith(showCents: !_settings.showCents));
  }

  /// Toggles vibration
  Future<void> toggleVibration() async {
    await updateSettings(
      _settings.copyWith(vibrationEnabled: !_settings.vibrationEnabled),
    );
  }

  /// Toggles sound
  Future<void> toggleSound() async {
    await updateSettings(
      _settings.copyWith(soundEnabled: !_settings.soundEnabled),
    );
  }

  /// Resets settings to default
  Future<void> resetToDefaults() async {
    await updateSettings(const Settings());
  }
}
