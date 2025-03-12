import 'package:deezer/deezer.dart';
import 'package:xelen/features/handler.dart';

import 'models.dart';

abstract class PlaylistService {
  const PlaylistService();

  Future<PlayListModel> fetchPlayList(String id);
}

class PlaylistRequestFailure extends Failure {}

class PlaylistCastFailure extends Failure {}

class DeezerPlaylistService extends PlaylistService with ResultHandler {
  const DeezerPlaylistService(this._client);

  final Deezer _client;

  @override
  Future<PlayListModel> fetchPlayList(String id) async {
    final response = await handlerService(
      request: () async => await _client.getPlaylistTracks(id),
      requestFailure: (err) => PlaylistRequestFailure(),
      parser: (response) => PlayListModel(
        tracks:
            List<TrackModel>.from(response?.data?.map(fromResponseModel) ?? [])
                .toList(),
        total: response?.total,
        checksum: response?.checksum,
      ),
      parserFailure: (err) => PlaylistCastFailure(),
    );
    return response!;
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
