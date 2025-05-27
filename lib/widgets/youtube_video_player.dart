import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class Youtubevideoplayer extends StatefulWidget {
  String url;
  Youtubevideoplayer({super.key, required this.url});

  @override
  State<Youtubevideoplayer> createState() => _YoutubevideoplayerState();
}

class _YoutubevideoplayerState extends State<Youtubevideoplayer> {
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
    ),
  );

  controller.addListener(() {
    if (controller.value.isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  });
}


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.blueAccent,
    );
  }
}
