class GrammarRule {
  final String title;
  final String explanation;
  final String example;
  final String exampleTranslation;
  final String level;
  bool isLearned;

  GrammarRule({
    required this.title,
    required this.explanation,
    required this.example,
    required this.exampleTranslation,
    required this.level,
    this.isLearned = false,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'explanation': explanation,
    'example': example,
    'exampleTranslation': exampleTranslation,
    'level': level,
    'isLearned': isLearned,
  };

  factory GrammarRule.fromJson(Map<String, dynamic> json) => GrammarRule(
    title: json['title'],
    explanation: json['explanation'],
    example: json['example'],
    exampleTranslation: json['exampleTranslation'],
    level: json['level'],
    isLearned: json['isLearned'] ?? false,
  );
}
