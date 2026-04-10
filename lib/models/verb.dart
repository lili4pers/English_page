class Verb {
  final String baseForm;
  final String pastSimple;
  final String pastParticiple;
  final String spanish;
  final String pronunciation;
  final String level;
  bool isLearned;

  Verb({
    required this.baseForm,
    required this.pastSimple,
    required this.pastParticiple,
    required this.spanish,
    required this.pronunciation,
    required this.level,
    this.isLearned = false,
  });

  Map<String, dynamic> toJson() => {
    'baseForm': baseForm,
    'pastSimple': pastSimple,
    'pastParticiple': pastParticiple,
    'spanish': spanish,
    'pronunciation': pronunciation,
    'level': level,
    'isLearned': isLearned,
  };

  factory Verb.fromJson(Map<String, dynamic> json) => Verb(
    baseForm: json['baseForm'],
    pastSimple: json['pastSimple'],
    pastParticiple: json['pastParticiple'],
    spanish: json['spanish'],
    pronunciation: json['pronunciation'],
    level: json['level'],
    isLearned: json['isLearned'] ?? false,
  );
}
