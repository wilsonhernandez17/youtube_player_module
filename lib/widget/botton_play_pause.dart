import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class BottonPlayPause extends StatelessWidget {
  final ValueNotifier<bool> _isMuted = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon:
              Icon(Icons.skip_previous, color: Theme.of(context).primaryColor),
          onPressed: context.ytController.previousVideo,
        ),
        YoutubeValueBuilder(
          builder: (context, value) {
            return IconButton(
              icon: Icon(
                value.playerState == PlayerState.playing
                    ? Icons.pause
                    : Icons.play_arrow,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: value.isReady
                  ? () {
                      value.playerState == PlayerState.playing
                          ? context.ytController.pause()
                          : context.ytController.play();
                    }
                  : null,
            );
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _isMuted,
          builder: (context, isMuted, _) {
            return IconButton(
              icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                _isMuted.value = !isMuted;
                isMuted
                    ? context.ytController.unMute()
                    : context.ytController.mute();
              },
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.skip_next, color: Theme.of(context).primaryColor),
          onPressed: context.ytController.nextVideo,
        ),
      ],
    );
  }
}
