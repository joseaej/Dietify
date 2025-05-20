import 'package:dietify/utils/theme.dart';
import 'package:flutter/material.dart';
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
    final videoID = YoutubePlayer.convertUrlToId(widget.url);
    controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: YoutubePlayerFlags(
            autoPlay: false, showLiveFullscreenButton: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [YoutubePlayer(controller: controller)],
    );
  }
}
