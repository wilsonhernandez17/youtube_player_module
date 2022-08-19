import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Volume extends StatelessWidget {
  final _volume = ValueNotifier<int>(100);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Volumen'),
        Expanded(
            child: ValueListenableBuilder<int>(
          valueListenable: _volume,
          builder: (context, volume, _) {
            return Slider(
                value: volume.toDouble(),
                min: 0.0,
                max: 100.0,
                onChanged: (value) {
                  _volume.value = value.round();
                  context.ytController.setVolume(volume);
                });
          },
        ))
      ],
    );
  }
}
