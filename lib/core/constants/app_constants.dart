/// App-wide constants
class AppConstants {
  AppConstants._();

  // ============================================================
  // APP INFO
  // ============================================================

  /// App name
  static const String appName = 'Guitar Tuna';

  /// App version
  static const String appVersion = '1.0.0';

  /// App build number
  static const int appBuildNumber = 1;

  /// App description
  static const String appDescription = 'Professional guitar tuner app';

  // ============================================================
  // AUDIO CONSTANTS
  // ============================================================

  /// Sample rate for audio recording (Hz)
  static const int sampleRate = 44100;

  /// FFT size
  static const int fftSize = 4096;

  /// Buffer size for audio processing
  static const int bufferSize = 2048;

  /// Minimum frequency to detect (Hz) - E2
  static const double minFrequency = 82.0;

  /// Maximum frequency to detect (Hz) - E6
  static const double maxFrequency = 1320.0;

  /// Default reference pitch A4 (Hz)
  static const double defaultReferencePitch = 440.0;

  /// Minimum reference pitch (Hz)
  static const double minReferencePitch = 430.0;

  /// Maximum reference pitch (Hz)
  static const double maxReferencePitch = 450.0;

  /// In-tune threshold (cents)
  /// Notes within this range are considered in tune
  static const double inTuneThreshold = 5.0;

  /// Minimum signal strength to process
  static const double minSignalStrength = 0.01;

  // ============================================================
  // UI CONSTANTS
  // ============================================================

  /// Default theme mode
  static const String defaultThemeMode = 'dark';

  /// Animation duration for theme changes (ms)
  static const int themeAnimationDuration = 300;

  /// Tuner update interval (ms)
  static const int tunerUpdateInterval = 50;

  // ============================================================
  // STORAGE KEYS
  // ============================================================

  /// Key for storing theme mode preference
  static const String keyThemeMode = 'theme_mode';

  /// Key for storing selected tuning
  static const String keySelectedTuning = 'selected_tuning';

  /// Key for storing reference pitch
  static const String keyReferencePitch = 'reference_pitch';

  /// Key for storing sensitivity
  static const String keySensitivity = 'sensitivity';

  /// Key for storing auto mode preference
  static const String keyAutoMode = 'auto_mode';

  // ============================================================
  // TUNING PRESETS
  // ============================================================

  /// Standard tuning ID
  static const String tuningStandard = 'standard';

  /// Drop D tuning ID
  static const String tuningDropD = 'drop_d';

  /// Drop C tuning ID
  static const String tuningDropC = 'drop_c';

  /// Open G tuning ID
  static const String tuningOpenG = 'open_g';

  /// DADGAD tuning ID
  static const String tuningDADGAD = 'dadgad';

  // ============================================================
  // NOTE NAMES
  // ============================================================

  /// All note names (chromatic scale)
  static const List<String> noteNames = [
    'C',
    'C#',
    'D',
    'D#',
    'E',
    'F',
    'F#',
    'G',
    'G#',
    'A',
    'A#',
    'B',
  ];

  /// Natural note names (no sharps/flats)
  static const List<String> naturalNotes = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];

  // ============================================================
  // GUITAR STRINGS (Standard Tuning)
  // ============================================================

  /// Guitar string names (low to high)
  static const List<String> guitarStrings = [
    'E', // 6th string (low E)
    'A', // 5th string
    'D', // 4th string
    'G', // 3rd string
    'B', // 2nd string
    'E', // 1st string (high E)
  ];

  /// Guitar string frequencies (Hz) for standard tuning
  static const List<double> guitarStringFrequencies = [
    82.41, // E2
    110.00, // A2
    146.83, // D3
    196.00, // G3
    246.94, // B3
    329.63, // E4
  ];

  // ============================================================
  // ERROR MESSAGES
  // ============================================================

  /// Microphone permission denied message
  static const String errorMicPermissionDenied =
      'Microphone permission is required to use the tuner';

  /// Audio initialization failed message
  static const String errorAudioInitFailed =
      'Failed to initialize audio. Please try again';

  /// Pitch detection failed message
  static const String errorPitchDetectionFailed =
      'Failed to detect pitch. Please check your microphone';

  /// Generic error message
  static const String errorGeneric = 'An error occurred. Please try again';

  // ============================================================
  // SUCCESS MESSAGES
  // ============================================================

  /// Settings saved message
  static const String successSettingsSaved = 'Settings saved successfully';

  /// Tuning changed message
  static const String successTuningChanged = 'Tuning changed';

  // ============================================================
  // URLS
  // ============================================================

  /// GitHub repository URL
  static const String githubUrl = 'https://github.com/hiucdh/guitar_tuna';

  /// Privacy policy URL (placeholder)
  static const String privacyPolicyUrl = 'https://example.com/privacy';

  /// Terms of service URL (placeholder)
  static const String termsOfServiceUrl = 'https://example.com/terms';

  // ============================================================
  // REGEX PATTERNS
  // ============================================================

  /// Pattern for validating frequency input
  static const String frequencyPattern = r'^\d+(\.\d+)?$';

  // ============================================================
  // LIMITS
  // ============================================================

  /// Maximum number of recent tunings to store
  static const int maxRecentTunings = 10;

  /// Maximum number of custom tunings
  static const int maxCustomTunings = 20;
}
