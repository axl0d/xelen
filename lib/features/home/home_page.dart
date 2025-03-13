import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../playlist/playlist.dart';
import '../playlist/providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deezer = ref.watch(deezerProvider);
    return deezer.when(
      data: (_) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Row(
            children: [
              Image.asset(
                "assets/img/logo.png",
                width: 40,
              ),
              Gap(12),
              Text("X e l e n")
            ],
          ),
          centerTitle: false,
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
      loading: () => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: Image.asset(
            "assets/img/logo.png",
            width: 160,
          ),
        ),
      ),
    );
  }
}
