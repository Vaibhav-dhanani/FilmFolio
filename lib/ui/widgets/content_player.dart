import 'package:filmfolio/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ContentPlayer extends StatelessWidget {
  final Movie movie;

  const ContentPlayer({Key? key, required this.movie}) : super(key: key);

  String? _getVideoId(String url) {
    return YoutubePlayer.convertUrlToId(url);
  }

  @override
  Widget build(BuildContext context) {
    final videoId = _getVideoId(movie.trailer);

    if (videoId == null) {
      return const Center(child: Text('Invalid YouTube URL'));
    }

    final YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return YoutubePlayer(
      controller: controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.amber,
      progressColors: const ProgressBarColors(
        playedColor: Colors.amber,
        handleColor: Colors.amberAccent,
      ),
      onReady: () {
        controller.play();
      },
    );
  }
}