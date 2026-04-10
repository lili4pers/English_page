import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/level.dart';

class ProgressProvider extends ChangeNotifier {
  Level _currentLevel = Level.beginner;
  int _vocabularyProgress = 0;
  int _verbsProgress = 0;
  int _adjectivesProgress = 0;
  int _grammarProgress = 0;
  int _totalExercisesCompleted = 0;
  int _totalListeningTime = 0;

  Level get currentLevel => _currentLevel;
  int get vocabularyProgress => _vocabularyProgress;
  int get verbsProgress => _verbsProgress;
  int get adjectivesProgress => _adjectivesProgress;
  int get grammarProgress => _grammarProgress;
  int get totalExercisesCompleted => _totalExercisesCompleted;
  int get totalListeningTime => _totalListeningTime;

  int get overallProgress {
    return ((vocabularyProgress +
                verbsProgress +
                adjectivesProgress +
                grammarProgress) /
            4)
        .round();
  }

  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final levelIndex = prefs.getInt('currentLevel') ?? 0;
    _currentLevel = Level.values[levelIndex];
    _vocabularyProgress = prefs.getInt('vocabularyProgress') ?? 0;
    _verbsProgress = prefs.getInt('verbsProgress') ?? 0;
    _adjectivesProgress = prefs.getInt('adjectivesProgress') ?? 0;
    _grammarProgress = prefs.getInt('grammarProgress') ?? 0;
    _totalExercisesCompleted = prefs.getInt('totalExercisesCompleted') ?? 0;
    _totalListeningTime = prefs.getInt('totalListeningTime') ?? 0;
    notifyListeners();
  }

  Future<void> setCurrentLevel(Level level) async {
    _currentLevel = level;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentLevel', level.index);
    notifyListeners();
  }

  Future<void> updateVocabularyProgress(int progress) async {
    _vocabularyProgress = progress.clamp(0, 100);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('vocabularyProgress', _vocabularyProgress);
    notifyListeners();
  }

  Future<void> updateVerbsProgress(int progress) async {
    _verbsProgress = progress.clamp(0, 100);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('verbsProgress', _verbsProgress);
    notifyListeners();
  }

  Future<void> updateAdjectivesProgress(int progress) async {
    _adjectivesProgress = progress.clamp(0, 100);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('adjectivesProgress', _adjectivesProgress);
    notifyListeners();
  }

  Future<void> updateGrammarProgress(int progress) async {
    _grammarProgress = progress.clamp(0, 100);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('grammarProgress', _grammarProgress);
    notifyListeners();
  }

  Future<void> incrementExercises() async {
    _totalExercisesCompleted++;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('totalExercisesCompleted', _totalExercisesCompleted);
    notifyListeners();
  }

  Future<void> addListeningTime(int seconds) async {
    _totalListeningTime += seconds;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('totalListeningTime', _totalListeningTime);
    notifyListeners();
  }

  Future<void> resetProgress() async {
    _currentLevel = Level.beginner;
    _vocabularyProgress = 0;
    _verbsProgress = 0;
    _adjectivesProgress = 0;
    _grammarProgress = 0;
    _totalExercisesCompleted = 0;
    _totalListeningTime = 0;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }
}
