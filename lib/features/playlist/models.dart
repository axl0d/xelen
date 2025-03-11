class PlayListModel {
  const PlayListModel({
    required this.tracks,
    required this.checksum,
    required this.total,
  });

  factory PlayListModel.fromJson(Map<String, dynamic> json) {
    return PlayListModel(
      tracks: json["data"] == null
          ? []
          : List<TrackModel>.from(
              json["data"]!.map((x) => TrackModel.fromJson(x))),
      checksum: json["checksum"],
      total: json["total"],
    );
  }

  final List<TrackModel> tracks;
  final String? checksum;
  final int? total;
}

class TrackModel {
  const TrackModel({
    required this.id,
    required this.title,
    required this.preview,
    required this.artist,
    required this.album,
    required this.type,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      id: json["id"],
      title: json["title"],
      preview: json["preview"],
      artist:
          json["artist"] == null ? null : ArtistModel.fromJson(json["artist"]),
      album: json["album"] == null ? null : AlbumModel.fromJson(json["album"]),
      type: json["type"],
    );
  }

  final String? id;
  final String? title;
  final String? preview;
  final ArtistModel? artist;
  final AlbumModel? album;
  final String? type;
}

class AlbumModel {
  const AlbumModel({
    required this.id,
    required this.title,
    required this.cover,
    required this.type,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json["id"],
      title: json["title"],
      cover: json["cover"],
      type: json["type"],
    );
  }

  final String? id;
  final String? title;
  final String? cover;
  final String? type;
}

class ArtistModel {
  const ArtistModel({
    required this.id,
    required this.name,
    required this.type,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      id: json["id"],
      name: json["name"],
      type: json["type"],
    );
  }

  final String? id;
  final String? name;
  final String? type;
}
