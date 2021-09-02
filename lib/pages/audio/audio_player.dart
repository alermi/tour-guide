import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:tour_guide/pages/audio/audio_page_manager.dart';

class AudioPlayerView extends StatefulWidget {
  const AudioPlayerView({Key? key, required AudioPageManager audioPageManager})
      : _pageManager = audioPageManager,
        super(key: key);
  final AudioPageManager _pageManager;

  static _AudioPlayerViewState? of(BuildContext context) =>
      context.findAncestorStateOfType<_AudioPlayerViewState>();

  @override
  _AudioPlayerViewState createState() => _AudioPlayerViewState(_pageManager);
}

class _AudioPlayerViewState extends State<AudioPlayerView> {
  late final AudioPageManager _pageManager;

  _AudioPlayerViewState(AudioPageManager _pageManager) {
    this._pageManager = _pageManager;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          ValueListenableBuilder<ProgressBarState>(
            valueListenable: _pageManager.progressNotifier,
            builder: (_, value, __) {
              return ProgressBar(
                progress: value.current,
                buffered: value.buffered,
                total: value.total,
                onSeek: _pageManager.seek,
              );
            },
          ),
          ValueListenableBuilder<ButtonState>(
            valueListenable: _pageManager.buttonNotifier,
            builder: (_, value, __) {
              switch (value) {
                case ButtonState.loading:
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    width: 32.0,
                    height: 32.0,
                    child: CircularProgressIndicator(),
                  );
                case ButtonState.paused:
                  return IconButton(
                    icon: Icon(Icons.play_arrow),
                    iconSize: 32.0,
                    onPressed: _pageManager.play,
                  );
                case ButtonState.playing:
                  return IconButton(
                    icon: Icon(Icons.pause),
                    iconSize: 32.0,
                    onPressed: _pageManager.pause,
                  );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }
}
