import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text_sample/main.dart';
import 'package:speech_to_text_sample/settings_screen.dart';

const PREF_KEY_RECORDING_TIME = "recording_time";

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    sttManager.init();
  }

  @override
  void dispose() {
    sttManager.closeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<String>(
          stream: sttManager.statusController.stream,
          builder: (context, snapshot) {
            return Text(snapshot.data ?? "");
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => _openSettingsScreen(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _clear(),
        child: Icon(Icons.refresh),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 8.0,
            ),
            StreamBuilder<bool>(
              stream: sttManager.isRecordingController.stream,
              builder: (context, snapshot) {
                return IconButton(
                  icon: Icon(Icons.keyboard_voice),
                  iconSize: 150.0,
                  onPressed: (snapshot.data != null && snapshot.data == true)
                      ? null
                      : () => _startRecording(),
                );
              },
            ),
            SizedBox(
              height: 8.0,
            ),
            Center(
              child: StreamBuilder<String>(
                  stream: sttManager.recordedTextController.stream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? "",
                      style: TextStyle(fontSize: 18.0),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  _clear() {
    sttManager.stopRecording();
  }

  _startRecording() {
    sttManager.startRecording();
  }

  _openSettingsScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => SettingsScreen()));
  }
}
