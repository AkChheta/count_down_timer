import 'dart:async';

import 'package:flutter/material.dart';

class CountDownTimerModel {
  TextEditingController seconds;
  int currentTime;
  Timer timer;
  bool? isRunning;

  CountDownTimerModel(
      {required this.seconds,
      required this.currentTime,
      required this.timer,
      required this.isRunning});
}
