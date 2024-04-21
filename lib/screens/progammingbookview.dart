import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProgrammingBookView extends StatefulWidget {
  final String programmingUrl;
  final String programmingId;
  final String title;
  final String email;
  final String youtube;
  final String programmingImages;
  final String videoUrl;
  final String content;

  const ProgrammingBookView({
    Key? key,
    required this.programmingUrl,
    required this.programmingId,
    required this.title,
    required this.email,
    required this.youtube,
    required this.programmingImages,
    required this.videoUrl,
    required this.content,
  }) : super(key: key);

  @override
  _ProgrammingBookViewState createState() => _ProgrammingBookViewState();
}

class _ProgrammingBookViewState extends State<ProgrammingBookView> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.videoUrl.isNotEmpty) {
      _controller = VideoPlayerController.network(widget.videoUrl)
        ..initialize().then((_) {
          setState(() {});
        })
        ..setLooping(true)
        ..play();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title.isNotEmpty)
                Text(widget.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              if (widget.email.isNotEmpty || widget.youtube.isNotEmpty)
                Row(
                  children: [
                    if (widget.email.isNotEmpty)
                      IconButton(
                        icon: Image.asset('assets/email.png'),
                        onPressed: () => launchUrl(Uri.parse('mailto:${widget.email}')),
                      ),
                    if (widget.youtube.isNotEmpty)
                    // Within the Row widget for email and YouTube icons in ProgrammingBookView
                      IconButton(
                        icon: Image.asset('assets/youtube.png'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebViewPage(url: widget.youtube),
                            ),
                          );
                        },
                      ),
      
                  ],
                ),
              if (widget.programmingImages.isNotEmpty)
                CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                  ),
                  items: widget.programmingImages.split(',').map((item) => Container(
                    child: Center(
                        child: Image.network(item, fit: BoxFit.cover, width: 1000)
                    ),
                  )).toList(),
                ),
              if (_controller != null && _controller!.value.isInitialized)
                AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      VideoPlayer(_controller!),
                      _PlayPauseOverlay(controller: _controller),
                    ],
                  ),
                ),
              if (widget.content.isNotEmpty)
                Text(widget.content, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key? key, this.controller}) : super(key: key);

  final VideoPlayerController? controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller!.value.isPlaying
              ? SizedBox.shrink()
              : Container(
            color: Colors.black26,
            child: Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 100.0,
                semanticLabel: 'Play',
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller!.value.isPlaying ? controller!.pause() : controller!.play();
          },
        ),
      ],
    );
  }
}



class WebViewPage extends StatelessWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube Video'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}