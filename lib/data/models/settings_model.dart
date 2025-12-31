import '../../domain/entities/settings.dart';

/// Settings data model with JSON serialization
class SettingsModel extends Settings {
  const SettingsModel({
    super.tuningId,
    super.referencePitch,
    super.themeMode,
    super.sensitivity,
    super.autoMode,
    super.showFrequency,
    super.showCents,
    super.vibrationEnabled,
    super.soundEnabled,
  });

  /// Creates a SettingsModel from JSON
  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      tuningId: json['tuningId'] as String? ?? 'standard',
      referencePitch: (json['referencePitch'] as num?)?.toDouble() ?? 440.0,
      themeMode: json['themeMode'] as String? ?? 'dark',
      sensitivity: (json['sensitivity'] as num?)?.toDouble() ?? 0.5,
      autoMode: json['autoMode'] as bool? ?? true,
      showFrequency: json['showFrequency'] as bool? ?? true,
      showCents: json['showCents'] as bool? ?? true,
      vibrationEnabled: json['vibrationEnabled'] as bool? ?? false,
      soundEnabled: json['soundEnabled'] as bool? ?? false,
    );
  }

  /// Converts SettingsModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'tuningId': tuningId,
      'referencePitch': referencePitch,
      'themeMode': themeMode,
      'sensitivity': sensitivity,
      'autoMode': autoMode,
      'showFrequency': showFrequency,
      'showCents': showCents,
      'vibrationEnabled': vibrationEnabled,
      'soundEnabled': soundEnabled,
    };
  }

  /// Creates a SettingsModel from Settings entity
  factory SettingsModel.fromEntity(Settings settings) {
    return SettingsModel(
      tuningId: settings.tuningId,
      referencePitch: settings.referencePitch,
      themeMode: settings.themeMode,
      sensitivity: settings.sensitivity,
      autoMode: settings.autoMode,
      showFrequency: settings.showFrequency,
      showCents: settings.showCents,
      vibrationEnabled: settings.vibrationEnabled,
      soundEnabled: settings.soundEnabled,
    );
  }

  /// Converts to Settings entity
  Settings toEntity() {
    return Settings(
      tuningId: tuningId,
      referencePitch: referencePitch,
      themeMode: themeMode,
      sensitivity: sensitivity,
      autoMode: autoMode,
      showFrequency: showFrequency,
      showCents: showCents,
      vibrationEnabled: vibrationEnabled,
      soundEnabled: soundEnabled,
    );
  }

  @override
  SettingsModel copyWith({
    String? tuningId,
    double? referencePitch,
    String? themeMode,
    double? sensitivity,
    bool? autoMode,
    bool? showFrequency,
    bool? showCents,
    bool? vibrationEnabled,
    bool? soundEnabled,
  }) {
    return SettingsModel(
      tuningId: tuningId ?? this.tuningId,
      referencePitch: referencePitch ?? this.referencePitch,
      themeMode: themeMode ?? this.themeMode,
      sensitivity: sensitivity ?? this.sensitivity,
      autoMode: autoMode ?? this.autoMode,
      showFrequency: showFrequency ?? this.showFrequency,
      showCents: showCents ?? this.showCents,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
    );
  }
}
