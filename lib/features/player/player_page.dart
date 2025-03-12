import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';

import '../playlist/models.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage(this.track, {super.key});

  final TrackModel track;

  @override
  State createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setUrl(widget.track.preview!);
  }

  void _togglePlayPause() {
    if (isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Gap(16),
            Image.network(
              widget.track.album?.cover ?? '',
              fit: BoxFit.fill,
            ),
            Gap(16),
            Text(
              widget.track.title ?? 'Sin título',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(4),
            Text(
              widget.track.artist?.name ?? 'Sin título',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Gap(8),
            StreamBuilder<Duration>(
              stream: _audioPlayer.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                return Column(
                  children: [
                    Slider(
                      min: 0,
                      max: 30,
                      value: position.inSeconds.toDouble(),
                      onChanged: (value) {
                        _audioPlayer.seek(Duration(seconds: value.toInt()));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          position.inSeconds > 10
                              ? Text('0:${position.inSeconds}')
                              : Text('0:0${position.inSeconds}'),
                          Text("0:30"),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.skip_previous),
                Gap(8),
                Card(
                  shape: CircleBorder(),
                  child: IconButton(
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    onPressed: _togglePlayPause,
                  ),
                ),
                Gap(8),
                Icon(Icons.skip_next),
              ],
            )
          ],
        ),
      ),
    );
  }
}
