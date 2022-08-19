import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widget/botton_play_pause.dart';
import 'widget/information.dart';
import 'widget/search_youtube.dart';
import 'widget/volume.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isMute = true;
  late YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      controller: _controller,
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          if (kIsWeb && constraints.maxWidth > 800) {
            return Row(
              children: [
                SizedBox(
                    height: size.height * 1,
                    width: size.width * 0.6,
                    child: player),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: size.width * 0.4,
                  height: size.height * 1,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Information(),
                        const SizedBox(
                          height: 20,
                        ),
                        SearchYoutube(),
                        const SizedBox(
                          height: 20,
                        ),
                        BottonPlayPause(),
                        const SizedBox(
                          height: 20,
                        ),
                        Volume()
                      ],
                    ),
                  ),
                )
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  player,
                  const SizedBox(
                    height: 10,
                  ),
                  const Information(),
                  const SizedBox(
                    height: 10,
                  ),
                  SearchYoutube(),
                  const SizedBox(
                    height: 10,
                  ),
                  BottonPlayPause(),
                  const SizedBox(
                    height: 10,
                  ),
                  Volume()
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'vVDsWvKZn4E',
      params: const YoutubePlayerParams(
        playlist: ['vVDsWvKZn4E'],
        startAt: Duration(minutes: 1, seconds: 36),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    };
    _controller.onExitFullscreen = () {};
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  Widget _player() {
    return YoutubePlayerControllerProvider(
        // Provides controller to all the widget below it.
        controller: _controller,
        child: YoutubeValueBuilder(
          controller:
              _controller, // This can be omitted, if using `YoutubePlayerControllerProvider`
          builder: (context, value) {
            return Column(
              children: [
                YoutubePlayerIFrame(
                  controller: _controller,
                  aspectRatio: 16 / 9,
                ),
              ],
            );
          },
        ));
  }
}
