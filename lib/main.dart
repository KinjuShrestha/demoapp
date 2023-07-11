import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyHomePagee extends StatefulWidget {
  const MyHomePagee({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePagee> createState() => _MyHomePageeState();
}

class _MyHomePageeState extends State<MyHomePagee> {
  AudioPlayer player = AudioPlayer();
  YoutubePlayerController? controller;

  setData() {
    controller = YoutubePlayerController(
      initialVideoId: 'uZucZZk2Tug',
      flags: const YoutubePlayerFlags(
        loop: false,
        autoPlay: true,
        mute: false,
        isLive: true,
        hideControls: true,
        hideThumbnail: true,
        controlsVisibleAtStart: false,
        showLiveFullscreenButton: false,
      ),
    );
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller!.play();

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          controller != null
              ? Align(
                  alignment: Alignment.topCenter,
                  child: YoutubePlayer(
                    controller: controller ??
                        YoutubePlayerController(initialVideoId: ''),
                    aspectRatio: 9 / 20,
                  ),
                )
              : const SizedBox(),
          Container(
            color: Colors.green,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await player.setAsset('assets/audio/kbc_right_answer.mp3');
                    await player.play();

                    if (player.processingState == ProcessingState.completed) {
                      controller!.play();
                    }
                  },
                  child: const Text('Correct Answer'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await player.setAsset('assets/audio/kbc_wrong_answer.mp3');
                    await player.play();
                    if (player.processingState == ProcessingState.completed) {
                      controller!.play();
                    }
                  },
                  child: const Text('Wrong Answer'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await player.setAsset('assets/audio/tick_tick.mp3');
                    await player.play();
                    if (player.processingState == ProcessingState.completed) {
                      controller!.play();
                    }
                  },
                  child: const Text('Tick Tick'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePagee(title: 'Flutter Demo Home Page'),
    );
  }
}
