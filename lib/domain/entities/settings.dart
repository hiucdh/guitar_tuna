import 'package:equatable/equatable.dart';

/// Settings entity - represents app settings
class Settings extends Equatable {
  /// Selected tuning ID
  final String tuningId;

  /// Reference pitch for A4 in Hz (default 440)
  final double referencePitch;

  /// Theme mode ('light', 'dark', 'system')
  final String themeMode;

  /// Sensitivity level (0.0 - 1.0)
  final double sensitivity;

  /// Auto mode enabled
  final bool autoMode;

  /// Show frequency display
  final bool showFrequency;

  /// Show cents display
  final bool showCents;

  /// Vibration feedback enabled
  final bool vibrationEnabled;

  /// Sound feedback enabled
  final bool soundEnabled;

  const Settings({
    this.tuningId = 'standard',
    this.referencePitch = 440.0,
    this.themeMode = 'dark',
    this.sensitivity = 0.5,
    this.autoMode = true,
    this.showFrequency = true,
    this.showCents = true,
    this.vibrationEnabled = false,
    this.soundEnabled = false,
  });

  @override
  List<Object?> get props => [
    tuningId,
    referencePitch,
    themeMode,
    sensitivity,
    autoMode,
    showFrequency,
    showCents,
    vibrationEnabled,
    soundEnabled,
  ];

  /// Creates a copy with modified fields
  Settings copyWith({
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
    return Settings(
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
