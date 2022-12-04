import 'package:flutter/material.dart';
import 'package:youtube_audio/utils/constants.dart';
import 'package:youtube_audio/widgets/icon_btn.dart';

class Controller extends StatelessWidget {
  const Controller({
    super.key,
    required this.onSetLoop,
    required this.onVolumeStateChange,
    required this.onPausePlay,
    required this.loopOn,
    required this.paused,
    required this.volumeOn,
  });

  final Function() onVolumeStateChange;
  final Function() onSetLoop;
  final Function() onPausePlay;
  final bool loopOn;
  final bool paused;
  final bool volumeOn;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Spacer(
          flex: 1,
        ),
        IconBtn(
          icon: loopOn ? Icons.repeat_one : Icons.repeat,
          onPress: onSetLoop,
          active: true,
        ),
        const SizedBox(
          width: 20,
        ),
        IconBtn(
          icon: paused ? Icons.play_arrow : Icons.pause,
          onPress: onPausePlay,
          large: true,
          active: true,
        ),
        const SizedBox(
          width: 20,
        ),
        IconBtn(
          icon: volumeOn ? Icons.volume_up : Icons.volume_off,
          onPress: onVolumeStateChange,
          active: true,
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
