import 'package:flutter/material.dart';
import 'package:speech_to_text_sample/stt_manager.dart';

import 'home_screen.dart';

SttManager sttManager = SttManager();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SpeechToTextSample",
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
