import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'features/player/player_page.dart';
import 'features/playlist/models.dart';
import 'features/playlist/providers.dart';

void main() async {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xelen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deezer = ref.watch(deezerProvider);
    return deezer.when(
      data: (_) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Xelen"),
        ),
        body: PlayList(),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note_outlined),
              label: 'Música',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Favoritas',
            )
          ],
        ),
      ),
      error: (_, __) => Scaffold(
        body: Center(
          child: Text("Error no se pudo iniciar la aplicación"),
        ),
      ),
      loading: () => ColoredBox(color: Theme.of(context).colorScheme.primary),
    );
  }
}

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
          return TrackItem(track: track);
        },
        itemCount: response.tracks.length,
      ),
      error: (_, __) => Text("Error al cargar la playlist"),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}

class TrackItem extends StatelessWidget {
  const TrackItem({
    super.key,
    required this.track,
  });

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
              child: Image.network(track.album?.cover ?? ''),
            ),
            title: Text(track.title ?? "Sin título"),
            trailing: Icon(Icons.play_arrow),
          ),
        ),
      ),
    );
  }
}
