import 'dart:async';

import 'package:flutter/scheduler.dart';

class Debouncer {
  final int seconds;

  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.seconds});

  factory Debouncer.medium() {
    return Debouncer(seconds: 3);
  }

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(Duration(seconds: seconds), action);
  }
}
