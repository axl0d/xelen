import 'package:deezer/deezer.dart';

import 'models.dart';

abstract class PlaylistService {
  const PlaylistService();

  Future<PlayListModel> fetchPlayList(String id);
}

class DeezerPlaylistService extends PlaylistService {
  const DeezerPlaylistService(this._client);

  final Deezer _client;

  @override
  Future<PlayListModel> fetchPlayList(String id) async {
    final response = await _client.getPlaylistTracks(id);

    return PlayListModel(
      tracks:
          List<TrackModel>.from(response?.data?.map(fromResponseModel) ?? [])
              .toList(),
      total: response?.total,
      checksum: response?.checksum,
    );
  }
}

TrackModel fromResponseModel(AlbumTrack track) => TrackModel(
      id: track.id,
      title: track.title,
      preview: track.preview,
      artist: ArtistModel(
        id: track.artist?.id,
        name: track.artist?.name,
        type: track.artist?.type,
      ),
      album: AlbumModel(
        id: track.album?.id,
        title: track.album?.title,
        cover: track.album?.cover,
        type: track.album?.type,
      ),
      type: track.type,
    );
