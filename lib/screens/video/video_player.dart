import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final String videoUrl;

  const VideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  /// TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController;

  ChewieController? _chewieController;

  bool _watched = false;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    await Future.wait([
      _videoPlayerController.initialize(),
    ]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,

      optionsBuilder: (context, defaultOptions) async {
        await showDialog<void>(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              content: ListView.builder(
                itemCount: defaultOptions.length,
                itemBuilder: (_, i) => ActionChip(
                  label: Text(defaultOptions[i].title),
                  onPressed: () => defaultOptions[i].onTap!(),
                ),
              ),
            );
          },
        );
      },
      optionsTranslation: OptionsTranslation(
        playbackSpeedButtonText: 'Wiedergabegeschwindigkeit',
        subtitlesButtonText: 'Untertitel',
        cancelButtonText: 'Abbrechen',
      ),

      // subtitle: Subtitles(
      //   [
      //     Subtitle(
      //       index: 0,
      //       start: Duration.zero,
      //       end: const Duration(seconds: 10),
      //       text: 'Hello from subtitles',
      //     ),
      //     Subtitle(
      //       index: 0,
      //       start: const Duration(seconds: 10),
      //       end: const Duration(seconds: 20),
      //       text: 'Whats up? :)',
      //     ),
      //   ],
      // ),
      // subtitleBuilder: (context, subtitle) => Container(
      //   padding: const EdgeInsets.all(10.0),
      //   child: Text(
      //     subtitle,
      //     style: const TextStyle(color: Colors.white),
      //   ),
      // ),
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final int videoDuration =
            _videoPlayerController.value.duration.inSeconds;

        final Duration? currentPosition = await _videoPlayerController.position;

        final currentDuration = currentPosition?.inSeconds;

        print(currentDuration);
        print(videoDuration);
        if (currentDuration != null) {
          if (currentDuration >= videoDuration / 2) {
            setState(() {
              _watched = true;
            });
          }

          print('this runs');
        }
        Navigator.of(context).pop(_watched);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconTheme.of(context),
            backgroundColor: Colors.transparent,
            title: const Text(''),
          ),
          body: Column(
            children: [
              Expanded(
                child: Center(
                  child: _chewieController != null &&
                          _chewieController!
                              .videoPlayerController.value.isInitialized
                      ? Theme(
                          // data: ThemeData(platform: TargetPlatform.iOS),
                          data: ThemeData(platform: Theme.of(context).platform),
                          child: Chewie(
                            controller: _chewieController!,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                            SizedBox(height: 20),
                            Text('Loading'),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//4 square
