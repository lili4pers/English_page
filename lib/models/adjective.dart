class Adjective {
  final String english;
  final String comparative;
  final String superlative;
  final String spanish;
  final String pronunciation;
  final String level;
  bool isLearned;

  Adjective({
    required this.english,
    required this.comparative,
    required this.superlative,
    required this.spanish,
    required this.pronunciation,
    required this.level,
    this.isLearned = false,
  });

  Map<String, dynamic> toJson() => {
    'english': english,
    'comparative': comparative,
    'superlative': superlative,
    'spanish': spanish,
    'pronunciation': pronunciation,
    'level': level,
    'isLearned': isLearned,
  };

  factory Adjective.fromJson(Map<String, dynamic> json) => Adjective(
    english: json['english'],
    comparative: json['comparative'],
    superlative: json['superlative'],
    spanish: json['spanish'],
    pronunciation: json['pronunciation'],
    level: json['level'],
    isLearned: json['isLearned'] ?? false,
  );
}
