/// Route names for navigation
class Routes {
  Routes._();

  // Main routes
  static const String home = '/';
  static const String tuner = '/tuner';
  static const String settings = '/settings';
  static const String about = '/about';

  // Settings sub-routes
  static const String tuning = '/tuning';
  static const String tuningSettings = '/settings/tuning';
  static const String audioSettings = '/settings/audio';
  static const String appearanceSettings = '/settings/appearance';

  // Chord routes
  static const String chords = '/chords';
  
  // Metronome
  static const String metronome = '/metronome';

  // All routes list
  static const List<String> all = [
    home,
    tuner,
    settings,
    about,
    tuningSettings,
    audioSettings,
    appearanceSettings,
  ];
}
