import 'dart:async';

import 'package:flutter/scheduler.dart';

class Debouncer {
  final int milliseconds;

  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  factory Debouncer.medium() {
    return Debouncer(milliseconds: 3000); // 3 seconds
  }

  factory Debouncer.fast() {
    return Debouncer(milliseconds: 100);
  }

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
