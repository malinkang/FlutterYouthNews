import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url;

  VideoPlayerScreen({@required this.url});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState(url: url);
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  ChewieController _chewieController;
  Future<void> _initializeVideoPlayerFuture;
  String url;
  _VideoPlayerScreenState({this.url});

  @override
  void initState() {
    // Create an store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    print("视频url = $url");
    _controller = VideoPlayerController.network(
      url,
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Chewie(
            controller: _chewieController,
          ),
        )
      ],
    );
  }
}
