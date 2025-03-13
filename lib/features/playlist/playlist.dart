import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../player/player_page.dart';
import 'models.dart';
import 'providers.dart';

class PlayList extends ConsumerWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlist = ref.watch(playListProvider);
    return playlist.when(
      data: (response) => ListView.separated(
        separatorBuilder: (_, __) => Gap(8),
        itemBuilder: (_, index) {
          final track = response.tracks[index];
          return _TrackItem(track: track);
        },
        itemCount: response.tracks.length,
      ),
      error: (_, __) => Text("Error al cargar la playlist"),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}

class _TrackItem extends StatelessWidget {
  const _TrackItem({required this.track});

  final TrackModel track;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PlayerPage(track)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: ListTile(
            leading: SizedBox.square(
              dimension: 40,
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  Image.network(
                    track.album?.cover ?? '',
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: Image.asset("assets/img/flutter_ec_logo.png"),
                  ),
                ],
              ),
            ),
            title: Text(track.title ?? "Sin título"),
            trailing: Icon(Icons.play_arrow),
          ),
        ),
      ),
    );
  }
}
