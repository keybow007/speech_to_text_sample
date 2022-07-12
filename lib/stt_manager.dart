import 'dart:async';

import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

/*
* Streamのお勉強
* https://www.woolha.com/tutorials/flutter-using-streamcontroller-and-streamsubscription
* */

class SttManager {
  final SpeechToText stt = SpeechToText();
  String locale = "";
  bool isSttReady = false;

  final statusController = StreamController<String>();
  final recordedTextController = StreamController<String>();
  final isRecordingController = StreamController<bool>();

  init() async {
    final isReady = await stt.initialize(
      onError: errorListener,
      onStatus: statusListener,
    );
    if (isReady) {
      //デフォでやるとen_JPになってしまうので自分で日本語を設定
      locale = "ja_JP";
    }
  }

  void errorListener(SpeechRecognitionError error) {
    statusController.sink.add("error: ${error.errorMsg} - ${error.permanent}");
  }

  void statusListener(String status) {
    statusController.sink.add(status);
  }

  void startRecording() async {
    this.isRecordingController.add(true);
    stt.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: 10),
      localeId: locale,
      cancelOnError: true,
      listenMode: ListenMode.confirmation,
    );
  }

  void stopRecording() {
    stt.stop();
    recordedTextController.add("");
    statusController.add("");
    this.isRecordingController.add(false);
  }

  void resultListener(SpeechRecognitionResult result) {
    recordedTextController.add(result.recognizedWords);
    this.isRecordingController.add(false);
  }

  void closeStream() {
    statusController.close();
    recordedTextController.close();
    isRecordingController.close();
  }
}
