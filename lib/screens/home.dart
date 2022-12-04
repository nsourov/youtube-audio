import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:youtube_audio/services/youtube_audio.dart';
import 'package:youtube_audio/utils/toast.dart';
import 'package:youtube_audio/utils/types.dart';
import 'package:youtube_audio/widgets/empty.dart';
import 'package:youtube_audio/widgets/icon_btn.dart';
import 'package:youtube_audio/widgets/player/audio_information.dart';
import 'package:youtube_audio/widgets/player/controller.dart';
import 'package:youtube_audio/widgets/url_input.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String url = "";
  bool playing = false;
  bool loopOn = false;
  bool paused = false;
  bool volumeOn = true;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  dynamic audioInfo;

  final player = AudioPlayer();

  void initState() {
    player.positionStream.listen((currPosition) {
      setState(() {
        position = currPosition;
      });
    });
    player.durationStream.listen((durationState) {
      setState(() {
        duration = durationState as Duration;
      });
    });
  }

  void handleSubmitUrl() async {
    if (!playing) {
      handlePlayAudio();
    } else {
      handleStopAudio();
    }
  }

  void handlePlayAudio() async {
    try {
      if (url.contains('playlist')) throw Error();
      final yt = YoutubeParser(url);
      String audio = await yt.getAudioUrlFromVideo();
      setState(() {
        playing = true;
        audioInfo = yt.getAudioInfo();
      });
      await player.setAudioSource(
        AudioSource.uri(
          Uri.parse(audio),
          tag: MediaItem(
            id: audioInfo.id.toString(),
            album: audioInfo.author.toString(),
            title: audioInfo.title.toString(),
            artUri: Uri.parse(audioInfo.thumbnails.standardResUrl.toString()),
          ),
        ),
      );
      await player.play();
    } catch (e) {
      print(e);
      setState(() {
        playing = false;
      });
      showToast(
        message: "Please enter valid youtube URL",
        type: ToastType.error,
      );
    }
  }

  void handleStopAudio() async {
    setState(() {
      audioInfo = null;
      playing = false;
      paused = false;
      loopOn = false;
      volumeOn = true;
    });
    await player.stop();
  }

  void handleOnChange(value) {
    setState(() {
      url = value;
    });
  }

  void handleSetLoop() async {
    await player.setLoopMode(loopOn ? LoopMode.off : LoopMode.one);
    setState(() {
      loopOn = !loopOn;
    });
  }

  void handlePausePlay() async {
    if (paused) {
      setState(() {
        paused = false;
      });
      await player.play();
    } else {
      setState(() {
        paused = true;
      });
      await player.pause();
    }
  }

  void handleVolume() async {
    await player.setVolume(volumeOn ? 0 : 1);
    setState(() {
      volumeOn = !volumeOn;
    });
  }

  void handleChangePosition(double value) async {
    final position = Duration(seconds: value.toInt());
    await player.seek(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Youtube Audio Player'),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12.00),
        child: body(),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Column body() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        form(),
        playing
            ? AudioInformation(
                thumbnail: audioInfo.thumbnails.standardResUrl,
                title: audioInfo.title,
                description: audioInfo.description,
                viewCount: audioInfo.engagement.viewCount,
                likeCount: audioInfo.engagement.likeCount,
                dislikeCount: audioInfo.engagement.dislikeCount,
                publishedDate: audioInfo.publishDate,
                duration: duration,
                position: position,
                onChangeSlider: handleChangePosition,
              )
            : EmptyPlayer(),
        playing
            ? Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Controller(
                  onPausePlay: handlePausePlay,
                  onSetLoop: handleSetLoop,
                  onVolumeStateChange: handleVolume,
                  loopOn: loopOn,
                  paused: paused,
                  volumeOn: volumeOn,
                ),
              )
            : Container(),
      ],
    );
  }

  Row form() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: UrlInput(onChange: handleOnChange),
        ),
        const SizedBox(
          width: 10.00,
        ),
        Expanded(
          flex: 0,
          child: IconBtn(
            icon: playing ? Icons.stop : Icons.play_arrow,
            onPress: handleSubmitUrl,
          ),
        ),
      ],
    );
  }
}
