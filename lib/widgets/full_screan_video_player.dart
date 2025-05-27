import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FullScreenYoutubePage extends StatefulWidget {
  final String url;

  const FullScreenYoutubePage({super.key, required this.url});

  @override
  State<FullScreenYoutubePage> createState() => _FullScreenYoutubePageState();
}

class _FullScreenYoutubePageState extends State<FullScreenYoutubePage> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    final videoID = YoutubePlayer.convertUrlToId(widget.url);
    controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        hideThumbnail: true,
        enableCaption: false,
        disableDragSeek: false,
        isLive: false,
        loop: false,
        mute: false,
        controlsVisibleAtStart: true,
        useHybridComposition: true,
      ),
    );

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _exitFullScreen(BuildContext context) async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: controller,
                showVideoProgressIndicator: true,
              ),
              builder: (context, player) {
                return player;
              },
            ),
          ),
          Positioned(
            top: 30,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.close, color: font, size: 30),
              onPressed: () => _exitFullScreen(context),
            ),
          ),
        ],
      ),
    );
  }
}
