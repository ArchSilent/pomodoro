import 'dart:async';
import 'package:flutter/material.dart';

class PomodoroTimer extends ChangeNotifier {
  late int _initialMinutes;
  late int _initialSeconds;
  int _remainingSeconds = 0;
  Timer? _timer;
  bool _isRunning = false;

  String get timeFormatted {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool get isRunning => _isRunning;

  void start(int minutes, int seconds) {
    if (_isRunning) return;

    _initialMinutes = minutes;
    _initialSeconds = seconds;
    _remainingSeconds = (_initialMinutes * 60) + _initialSeconds;
    _isRunning = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        stop();
      }
    });

    notifyListeners();
  }

  void startFromRemaining() {
    if (_isRunning) return;

    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        stop();
      }
    });

    notifyListeners();
  }

  void stop() {
    _timer?.cancel();
    _isRunning = false;
    notifyListeners();
  }

  void reset() {
    stop();
    _remainingSeconds = (_initialMinutes * 60) + _initialSeconds;
    notifyListeners();
  }

  void updateTime(int minutes, int seconds) {
    _initialMinutes = minutes;
    _initialSeconds = seconds;
    _remainingSeconds = (minutes * 60) + seconds;
    notifyListeners(); // Notificar para actualizar la interfaz inmediatamente
  }
}
