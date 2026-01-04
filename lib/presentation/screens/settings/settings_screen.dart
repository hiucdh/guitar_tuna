import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_provider.dart';
import '../../providers/theme_provider.dart';
import '../../../core/extensions/context_extension.dart';

/// Settings screen
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // Theme section
          _buildSection(
            context,
            title: 'Appearance',
            children: [
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return ListTile(
                    leading: Icon(
                      themeProvider.isDarkMode
                          ? Icons.dark_mode
                          : Icons.light_mode,
                    ),
                    title: const Text('Theme'),
                    subtitle: Text(themeProvider.themeModeString.toUpperCase()),
                    trailing: Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (_) => themeProvider.toggleTheme(),
                    ),
                  );
                },
              ),
            ],
          ),

          // Audio section
          _buildSection(
            context,
            title: 'Audio',
            children: [
              Consumer<SettingsProvider>(
                builder: (context, settings, child) {
                      return Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.music_note),
                            title: const Text('Tuning Mode'),
                            subtitle: Text('Current: ${settings.selectedTuningId.toUpperCase().replaceAll('_', ' ')}'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => Navigator.pushNamed(context, '/tuning'),
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(Icons.tune),
                            title: const Text('Reference Pitch'),
                            subtitle: Text('${settings.referencePitch} Hz'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              // TODO: Show reference pitch dialog
                            },
                          ),
                      ListTile(
                        leading: const Icon(Icons.graphic_eq),
                        title: const Text('Sensitivity'),
                        subtitle: Text(
                          '${(settings.sensitivity * 100).toInt()}%',
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          // TODO: Show sensitivity dialog
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),

          // Display section
          _buildSection(
            context,
            title: 'Display',
            children: [
              Consumer<SettingsProvider>(
                builder: (context, settings, child) {
                  return Column(
                    children: [
                      SwitchListTile(
                        secondary: const Icon(Icons.show_chart),
                        title: const Text('Show Frequency'),
                        value: settings.showFrequency,
                        onChanged: (_) => settings.toggleShowFrequency(),
                      ),
                      SwitchListTile(
                        secondary: const Icon(Icons.straighten),
                        title: const Text('Show Cents'),
                        value: settings.showCents,
                        onChanged: (_) => settings.toggleShowCents(),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),

          // Feedback section
          _buildSection(
            context,
            title: 'Feedback',
            children: [
              Consumer<SettingsProvider>(
                builder: (context, settings, child) {
                  return Column(
                    children: [
                      SwitchListTile(
                        secondary: const Icon(Icons.vibration),
                        title: const Text('Vibration'),
                        value: settings.vibrationEnabled,
                        onChanged: (_) => settings.toggleVibration(),
                      ),
                      SwitchListTile(
                        secondary: const Icon(Icons.volume_up),
                        title: const Text('Sound'),
                        value: settings.soundEnabled,
                        onChanged: (_) => settings.toggleSound(),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),

          // Reset section
          _buildSection(
            context,
            title: 'Advanced',
            children: [
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About'),
                onTap: () => Navigator.pushNamed(context, '/about'),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.restore, color: Colors.red),
                title: const Text('Reset to Defaults'),
                onTap: () async {
                  final confirmed = await context.showAlertDialog(
                    title: 'Reset Settings',
                    message:
                        'Are you sure you want to reset all settings to defaults?',
                    confirmText: 'Reset',
                    cancelText: 'Cancel',
                  );

                  if (confirmed == true && context.mounted) {
                    context.read<SettingsProvider>().resetToDefaults();
                    context.showSuccessSnackBar('Settings reset to defaults');
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }
}
