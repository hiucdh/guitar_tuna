import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/extensions/context_extension.dart';

/// About screen
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // App icon/logo
          const Icon(Icons.music_note, size: 80),
          const SizedBox(height: 24),

          // App name
          Text(
            AppConstants.appName,
            style: context.textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Version
          Text(
            'Version ${AppConstants.appVersion}',
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Description
          Text(
            AppConstants.appDescription,
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),

          // Features
          _buildSection(
            context,
            title: 'Features',
            items: [
              'Accurate pitch detection',
              'Multiple tuning presets',
              'Custom tuning support',
              'Visual tuning feedback',
              'Dark and light themes',
            ],
          ),
          const SizedBox(height: 32),

          // Links
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.code),
                  title: const Text('Source Code'),
                  subtitle: const Text('View on GitHub'),
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () {
                    // TODO: Open GitHub URL
                    context.showSnackBar('Opening GitHub...');
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.bug_report),
                  title: const Text('Report Issue'),
                  subtitle: const Text('Found a bug?'),
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () {
                    // TODO: Open issues URL
                    context.showSnackBar('Opening issues page...');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Copyright
          Text(
            '© 2025 Guitar Tuna',
            style: context.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Made with ❤️ using Flutter',
            style: context.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 20,
                  color: context.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(item, style: context.textTheme.bodyLarge)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
