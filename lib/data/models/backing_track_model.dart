import '../../domain/entities/backing_track.dart';

class BackingTrackModel extends BackingTrack {
  const BackingTrackModel({
    required super.id,
    required super.title,
    required super.key,
    required super.assetPath,
  });

  factory BackingTrackModel.fromJson(Map<String, dynamic> json) {
    return BackingTrackModel(
      id: json['id'],
      title: json['title'],
      key: json['key'],
      assetPath: json['assetPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'key': key,
      'assetPath': assetPath,
    };
  }
}
