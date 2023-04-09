import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';


class PlayVideoFromNetwork extends StatefulWidget {
  final String videoKey;
  const PlayVideoFromNetwork({Key? key, required this.videoKey}) : super(key: key);

  @override
  State<PlayVideoFromNetwork> createState() => _PlayVideoFromNetworkState();
}

class _PlayVideoFromNetworkState extends State<PlayVideoFromNetwork> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/${widget.videoKey}'),
        podPlayerConfig: const PodPlayerConfig(
            autoPlay: false,
            isLooping: false,
            videoQualityPriority: [1080, 720]
        ))..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PodVideoPlayer(controller: controller),
    );
  }
}