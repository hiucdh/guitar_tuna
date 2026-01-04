import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'presentation/navigation/app_router.dart';
import 'presentation/navigation/routes.dart';
import 'presentation/providers/settings_provider.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/providers/tuner_provider.dart';
import 'services/audio/audio_service.dart';
import 'services/permission/permission_service.dart';
import 'data/datasources/local/local_data_source.dart';
import 'data/repositories/settings_repository_impl.dart';
import 'data/repositories/audio_repository_impl.dart';
import 'data/repositories/tuning_repository_impl.dart';
import 'domain/repositories/tuning_repository.dart';
import 'domain/usecases/get_settings.dart';
import 'domain/usecases/save_settings.dart';
import 'domain/usecases/calculate_cents.dart';
import 'domain/usecases/detect_pitch.dart';
import 'domain/usecases/get_closest_note.dart';
import 'domain/usecases/get_chords.dart';
import 'data/repositories/chord_repository_impl.dart';
import 'presentation/providers/chord_provider.dart';

/// Main app widget with provider setup
class GuitarTunaApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const GuitarTunaApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    // Initialize services
    final audioService = AudioService();
    final permissionService = PermissionService();

    // Initialize data sources and repositories
    final localDataSource = LocalDataSource(sharedPreferences);
    final settingsRepository = SettingsRepositoryImpl(localDataSource);
    final audioRepository = AudioRepositoryImpl(audioService, permissionService);

    // Initialize use cases
    final getSettings = GetSettings(settingsRepository);
    final saveSettings = SaveSettings(settingsRepository);
    final calculateCents = CalculateCents();
    final detectPitch = DetectPitch(audioRepository);
    final getClosestNote = GetClosestNote();
    final chordRepository = ChordRepositoryImpl();
    final getChords = GetChords(chordRepository);

    return MultiProvider(
      providers: [
        // Theme provider
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        // Settings provider
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(
            getSettings: getSettings,
            saveSettings: saveSettings,
          )..loadSettings(),
        ),

        // Tuner provider
        ChangeNotifierProvider(
          create: (_) => TunerProvider(
            detectPitch: detectPitch,
            calculateCents: calculateCents,
            getClosestNote: getClosestNote,
          ),
        ),

        // Tuning Repository
        Provider<TuningRepository>(
          create: (_) => TuningRepositoryImpl(localDataSource),
        ),

        // Chord Provider
        ChangeNotifierProvider(
          create: (_) => ChordProvider(getChords: getChords),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            // App title
            title: AppConstants.appName,

            // Debug banner
            debugShowCheckedModeBanner: false,

            // Theme
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,

            // Navigation
            initialRoute: Routes.home,
            onGenerateRoute: AppRouter.onGenerateRoute,
            onUnknownRoute: AppRouter.onUnknownRoute,
          );
        },
      ),
    );
  }
}
