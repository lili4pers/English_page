import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsProvider extends ChangeNotifier {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isPlaying = false;
  double _speechRate = 0.5;
  double _pitch = 1.0;

  bool get isPlaying => _isPlaying;
  double get speechRate => _speechRate;
  double get pitch => _pitch;

  TtsProvider() {
    _initTts();
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(_speechRate);
    await _flutterTts.setPitch(_pitch);
    await _flutterTts.setVolume(1.0);

    _flutterTts.setStartHandler(() {
      _isPlaying = true;
      notifyListeners();
    });

    _flutterTts.setCompletionHandler(() {
      _isPlaying = false;
      notifyListeners();
    });

    _flutterTts.setErrorHandler((msg) {
      _isPlaying = false;
      notifyListeners();
    });
  }

  Future<void> speak(String text) async {
    if (_isPlaying) {
      await stop();
    }
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> setSpeechRate(double rate) async {
    _speechRate = rate;
    await _flutterTts.setSpeechRate(rate);
    notifyListeners();
  }

  Future<void> setPitch(double pitch) async {
    _pitch = pitch;
    await _flutterTts.setPitch(pitch);
    notifyListeners();
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
}
