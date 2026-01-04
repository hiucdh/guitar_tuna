import 'package:equatable/equatable.dart';

class BackingTrack extends Equatable {
  final String id;
  final String title;
  final String key; // e.g., 'C Major', 'A Minor'
  final String assetPath;

  const BackingTrack({
    required this.id,
    required this.title,
    required this.key,
    required this.assetPath,
  });

  @override
  List<Object?> get props => [id, title, key, assetPath];
}
