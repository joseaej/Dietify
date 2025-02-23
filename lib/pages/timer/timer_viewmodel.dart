import 'dart:async';

import 'package:flutter/material.dart';

class TimerViewmodel extends ChangeNotifier {
  Duration duration = Duration(minutes: 20);
  bool isRunning = false;
  final stopwatch = Stopwatch()..start();
  String timer = "20:00";

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    timer = "$minutes:$seconds";
    return "$minutes:$seconds";
  }

  void start(Duration duration) {
    this.duration = duration;
    isRunning = true;
    Timer.periodic(Duration(seconds: 1), (watch) {
      String elapsedTime = formatDuration(stopwatch.elapsed);
      timer=elapsedTime;
    if (stopwatch.elapsed.inSeconds >= 10) {
      watch.cancel();
    }
  });
  }

  void pause() {
    isRunning = !isRunning;
    notifyListeners();
  }

  void stop() {
    isRunning = false;
    notifyListeners();
  }
}
