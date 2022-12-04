import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:youtube_audio/screens/home.dart';
import 'package:youtube_audio/utils/constants.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.naimur.youtubeAudio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: kPrimaryColor,
        ),
        scaffoldBackgroundColor: kPrimaryColor,
      ),
      home: Home(),
    );
  }
}
