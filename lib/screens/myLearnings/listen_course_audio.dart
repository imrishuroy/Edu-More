import 'dart:io';
// import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';

import '/screens/myLearnings/widgets/player_widget.dart';
import '/widgets/no_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef OnError = void Function(Exception exception);

// const kUrl1 = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';
// const kUrl2 = 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3';
// const kUrl3 = 'http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1xtra_mf_p';

class ListenCourseAudio extends StatefulWidget {
  final String? audioUrl;

  const ListenCourseAudio({Key? key, required this.audioUrl}) : super(key: key);
  @override
  _ListenCourseAudioState createState() => _ListenCourseAudioState();
}

class _ListenCourseAudioState extends State<ListenCourseAudio> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  String? localFilePath;
  String? localAudioCacheURI;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      // Calls to Platform.isIOS fails on web
      return;
    }
    if (Platform.isIOS) {
      audioCache.fixedPlayer?.notificationService.startHeadlessService();
      advancedPlayer.notificationService.startHeadlessService();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.audioUrl != null) {
      return MultiProvider(
        providers: [
          StreamProvider<Duration>.value(
            initialData: const Duration(),
            value: advancedPlayer.onAudioPositionChanged,
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.amber),
            backgroundColor: Colors.transparent,
            //   title: Text('Audio'),
          ),
          //  body: remoteUrl(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PlayerWidget(url: widget.audioUrl!),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.amber),
        backgroundColor: Colors.transparent,
        //   title: Text('Audio'),
      ),
      body: const Center(
        child: NoData(),
      ),
    );
  }
}
