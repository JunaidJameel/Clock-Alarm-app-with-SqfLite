import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class ClockState extends ChangeNotifier {
  late Timer _timer;

  ClockState() {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
