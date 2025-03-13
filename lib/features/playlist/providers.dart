import 'package:deezer/deezer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models.dart';
import 'playlist_service.dart';

const arl =
    'd6a1dcdbf438674baf59dd786ecb146dd226ed675a9606e2049d8ae4a856c50bc4ee8e78bb9b7c4c4e1ea6a3977f7d916803cd2471b657a6071aa7bd432a390cc64aaad7660d6caa3bd695857a8cfad3c8e1cb324259c1fd7915e440bf5fdfee';

const playListId = "908622995";

sealed class DeezerInstance {
  const DeezerInstance();
}

class DeezerInstanceLoading extends DeezerInstance {}

class DeezerInstanceSuccess extends DeezerInstance {
  const DeezerInstanceSuccess(this.instance);

  final Deezer instance;
}

class DeezerInstanceError extends DeezerInstance {}

final deezerProvider = FutureProvider<Deezer>((_) async {
  return Deezer.create(arl: arl);
});

final deezerInstanceProvider = Provider<DeezerInstance>(
  (ref) {
    final provider = ref.watch(deezerProvider);
    return provider.when(
      data: (instance) => DeezerInstanceSuccess(instance),
      error: (_, __) => DeezerInstanceError(),
      loading: () => DeezerInstanceLoading(),
    );
  },
);

final playListProvider = FutureProvider<PlayListModel?>(
  (ref) async {
    final deezerClient =
        ref.watch(deezerInstanceProvider) as DeezerInstanceSuccess;
    final service = DeezerPlaylistService(deezerClient.instance);
    return service.fetchPlayList(playListId);
  },
);
