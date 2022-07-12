import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text_sample/home_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double recordingTimeSeconds = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("設定"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.timer),
            SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("録音時間"),
                  Slider(
                    onChanged: (value) => _setRecordingTime(value),
                    value: recordingTimeSeconds,
                    min: 0.0,
                    max: 10.0,
                    divisions: 10,
                    label: recordingTimeSeconds.toInt().toString(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _setRecordingTime(double value) async {
    setState(() {
      recordingTimeSeconds = value;
    });
    final timeConverted = value.toInt();
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(PREF_KEY_RECORDING_TIME, timeConverted);
  }
}
