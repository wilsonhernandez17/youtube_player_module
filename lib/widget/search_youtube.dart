import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class SearchYoutube extends StatefulWidget {
  @override
  State<SearchYoutube> createState() => _SearchYoutubeState();
}

class _SearchYoutubeState extends State<SearchYoutube> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return YoutubeValueBuilder(builder: (context, value) {
      return Column(
        children: [
          TextField(
            enabled: value.isReady,
            controller: _textEditingController,
            decoration: InputDecoration(
                icon: const Icon(Icons.youtube_searched_for_sharp),
                iconColor: Theme.of(context).primaryColor,
                hintText: 'Ingrese url del video ',
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal))),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              context.ytController
                  .load(_cleanId(_textEditingController.text) ?? '');
            },
            child: Container(
              height: 50,
              width: size.width * 0.2,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                  child: Text(
                'Buscar',
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ],
      );
    });
  }

  String? _cleanId(String source) {
    if (source.startsWith('http://') || source.startsWith('https://')) {
      return YoutubePlayerController.convertUrlToId(source);
    } else if (source.length != 11) {}
    return source;
  }
}
