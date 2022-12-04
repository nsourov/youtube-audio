import 'dart:io';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeParser {
  YoutubeParser(this.url);

  final String url;
  dynamic _video;
  final _yt = YoutubeExplode();

  Future<String> getAudioUrlFromVideo() async {
    try {
      _video = await _yt.videos.get(url);
      var manifest = await _yt.videos.streamsClient.getManifest(_video.id);
      var audio = Platform.isIOS
          ? manifest.muxed.withHighestBitrate().url.toString()
          : manifest.audioOnly.withHighestBitrate().url.toString();

      return audio;
    } catch (e) {
      print("Something went wrong in getAudioUrlFromVideo method: $e");
      throw e;
    }
  }

  dynamic getAudioInfo() {
    return _video;
  }
}
