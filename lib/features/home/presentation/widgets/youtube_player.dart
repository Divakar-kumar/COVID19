import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';

class YoutubePlayer extends StatefulWidget {
  final videoId;
  YoutubePlayer(this.videoId);
  @override
  _YoutubeAppState createState() => _YoutubeAppState(videoId);
}

class _YoutubeAppState extends State<YoutubePlayer>
    implements YouTubePlayerListener {

  double _currentVideoSecond = 0.0;
  String _playerState = "";
  FlutterYoutubeViewController _controller;
  final videoId;
  _YoutubeAppState(this.videoId);
  @override
  void onCurrentSecond(double second) {
    print("onCurrentSecond second = $second");
    _currentVideoSecond = second;
  }

  @override
  void onError(String error) {
    print("onError error = $error");
  }

  @override
  void onReady() {
    print("onReady");
  }

  @override
  void onStateChange(String state) {
    print("onStateChange state = $state");
    setState(() {
      _playerState = state;
    });
  }

  @override
  void onVideoDuration(double duration) {
    print("onVideoDuration duration = $duration");
  }

  void _onYoutubeCreated(FlutterYoutubeViewController controller) {
    this._controller = controller;
  }

  void _loadOrCueVideo() {
    _controller.loadOrCueVideo(videoId, _currentVideoSecond);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[
            Container(
                child: FlutterYoutubeView(
              onViewCreated: _onYoutubeCreated,
              listener: this,
              params: YoutubeParam(
                videoId: videoId,
                showUI: true,                
                autoPlay: true,
                showYoutube: false,
                showFullScreen: false,
              ),
            )),
          ],
        );
  }
}
