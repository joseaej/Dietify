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
  void dispose() {
    super.dispose();
    controller.dispose();
  }
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
    return YoutubePlayer(controller: controller);
  }
}
