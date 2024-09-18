import 'package:filmfolio/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ContentPlayer extends StatefulWidget {
  final Movie movie;

  const ContentPlayer({Key? key, required this.movie}) : super(key: key);

  @override
  _ContentPlayerState createState() => _ContentPlayerState();
}

class _ContentPlayerState extends State<ContentPlayer> {
  late VideoPlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _controller = VideoPlayerController.network(widget.movie.trailer)
      ..initialize().then((_) {
        setState(() {
          _isPlayerReady = true;
        });
        _controller.play(); // Optionally play the video automatically
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isPlayerReady
          ? AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      )
          : const CircularProgressIndicator(),
    );
  }
}
