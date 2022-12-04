import 'package:flutter/material.dart';
import 'package:youtube_audio/utils/constants.dart';
import 'package:youtube_audio/widgets/icon_btn.dart';

class AudioInformation extends StatelessWidget {
  const AudioInformation({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.description,
    required this.viewCount,
    required this.likeCount,
    required this.dislikeCount,
    required this.publishedDate,
    required this.duration,
    required this.position,
    required this.onChangeSlider,
  });

  final String thumbnail;
  final String title;
  final String description;
  final int viewCount;
  final int likeCount;
  final int dislikeCount;
  final DateTime publishedDate;
  final Duration duration;
  final Duration position;
  final Function(double) onChangeSlider;

  String format(Duration d) => d.toString().substring(2, 7);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(thumbnail),
              radius: 150,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 20.00,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              description.isNotEmpty ? description : "No description",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 16.00,
                color: Colors.white54,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Column(
              children: [
                Slider(
                  value: position.inSeconds.toDouble(),
                  max: duration.inSeconds.toDouble(),
                  min: 0,
                  onChanged: onChangeSlider,
                  divisions: 90,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(format(position)),
                      Text(format(duration)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
