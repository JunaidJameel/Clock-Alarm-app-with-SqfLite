import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class TimeProvider with ChangeNotifier {
  DateTime _currentTime = DateTime.now();
  DateTime _currentDate = DateTime.now();

  Timer? _timer;

  DateTime get currentTime => _currentTime;
  DateTime get currentDate => _currentDate;
  TimeProvider() {
    _currentDate = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _currentTime = DateTime.now();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
