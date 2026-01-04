import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/backing_track.dart';
import '../../domain/repositories/practice_repository.dart';

class PracticeRepositoryImpl implements PracticeRepository {
  @override
  Future<List<BackingTrack>> getBackingTracks() async {
    try {
      // Load asset manifest
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      // Filter for files in backing_tracks directory
      final backingTracksPaths = manifestMap.keys
          .where((String key) => key.contains('assets/audio/backing_tracks/') && key.contains('.mp3'))
          .toList();

      List<BackingTrack> tracks = [];
      
      if (backingTracksPaths.isEmpty) {
        // Return some dummy data if no files found (for testing)
        // Or return empty list
        return [
          const BackingTrack(
            id: '1', 
            title: 'C Major Backing Track', 
            key: 'C Major', 
            assetPath: 'assets/audio/backing_tracks/c_major.mp3'
          ),
          const BackingTrack(
            id: '2', 
            title: 'A Minor Backing Track', 
            key: 'A Minor', 
            assetPath: 'assets/audio/backing_tracks/a_minor.mp3'
          ),
        ];
      }

      for (var path in backingTracksPaths) {
        // Infer title and key from filename
        // Expected format: assets/audio/backing_tracks/Key_Title.mp3 or just Title.mp3
        final filename = path.split('/').last.replaceAll('.mp3', '');
        final parts = filename.split('_');
        
        String title = filename.replaceAll('_', ' ');
        String key = 'Unknown';
        
        // Heuristic:
        // If filename is "Key_Scale_Title", e.g. "C_Major_Ballad"
        // key = "C Major"
        // If "C_Ballad" -> key = "C"
        
        if (parts.length >= 2) {
          final secondPart = parts[1].toLowerCase();
          if (secondPart == 'major' || secondPart == 'minor') {
            key = '${parts[0]} ${parts[1]}';
          } else {
            key = parts[0];
          }
        } else if (parts.isNotEmpty) {
           key = parts[0]; 
        }

        tracks.add(BackingTrack(
          id: path,
          title: title,
          key: key,
          assetPath: path,
        ));
      }

      return tracks;
    } catch (e) {
      // Fallback
      return [];
    }
  }
}
