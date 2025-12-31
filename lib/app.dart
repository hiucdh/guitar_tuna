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
import 'data/datasources/local/local_data_source.dart';
import 'data/repositories/settings_repository_impl.dart';
import 'domain/usecases/get_settings.dart';
import 'domain/usecases/save_settings.dart';
import 'domain/usecases/calculate_cents.dart';

/// Main app widget with provider setup
class GuitarTunaApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const GuitarTunaApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    // Initialize data sources and repositories
    final localDataSource = LocalDataSource(sharedPreferences);
    final settingsRepository = SettingsRepositoryImpl(localDataSource);

    // Initialize use cases
    final getSettings = GetSettings(settingsRepository);
    final saveSettings = SaveSettings(settingsRepository);
    final calculateCents = CalculateCents();

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
          create: (_) => TunerProvider(calculateCents: calculateCents),
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
