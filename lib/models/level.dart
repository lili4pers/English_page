enum Level { beginner, intermediate, advanced }

extension LevelExtension on Level {
  String get name {
    switch (this) {
      case Level.beginner:
        return 'Principiante';
      case Level.intermediate:
        return 'Intermedio';
      case Level.advanced:
        return 'Avanzado';
    }
  }

  String get percentage {
    switch (this) {
      case Level.beginner:
        return '0-33%';
      case Level.intermediate:
        return '34-66%';
      case Level.advanced:
        return '67-100%';
    }
  }

  String get color {
    switch (this) {
      case Level.beginner:
        return '0xFF4CAF50';
      case Level.intermediate:
        return '0xFFFF9800';
      case Level.advanced:
        return '0xFFF44336';
    }
  }

  static Level fromString(String value) {
    switch (value) {
      case 'beginner':
        return Level.beginner;
      case 'intermediate':
        return Level.intermediate;
      case 'advanced':
        return Level.advanced;
      default:
        return Level.beginner;
    }
  }
}
