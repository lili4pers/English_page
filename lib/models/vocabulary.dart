class Vocabulary {
  final String english;
  final String spanish;
  final String pronunciation;
  final String category;
  final String level;
  bool isLearned;

  Vocabulary({
    required this.english,
    required this.spanish,
    required this.pronunciation,
    required this.category,
    required this.level,
    this.isLearned = false,
  });

  Map<String, dynamic> toJson() => {
    'english': english,
    'spanish': spanish,
    'pronunciation': pronunciation,
    'category': category,
    'level': level,
    'isLearned': isLearned,
  };

  factory Vocabulary.fromJson(Map<String, dynamic> json) => Vocabulary(
    english: json['english'],
    spanish: json['spanish'],
    pronunciation: json['pronunciation'],
    category: json['category'],
    level: json['level'],
    isLearned: json['isLearned'] ?? false,
  );
}
