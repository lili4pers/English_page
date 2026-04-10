import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/lesson_data.dart';
import '../models/grammar_rule.dart';
import '../models/level.dart';
import '../providers/progress_provider.dart';
import '../providers/tts_provider.dart';

class GrammarScreen extends StatefulWidget {
  final Level level;

  const GrammarScreen({super.key, required this.level});

  @override
  State<GrammarScreen> createState() => _GrammarScreenState();
}

class _GrammarScreenState extends State<GrammarScreen> {
  late List<GrammarRule> _rules;
  int _currentIndex = 0;
  int _learnedCount = 0;

  @override
  void initState() {
    super.initState();
    _rules = LessonData.getGrammarRules(widget.level.name.toLowerCase());
    _loadProgress();
  }

  void _loadProgress() {
    final provider = context.read<ProgressProvider>();
    switch (widget.level) {
      case Level.beginner:
        _learnedCount = (_rules.length * provider.grammarProgress / 100)
            .round();
        break;
      case Level.intermediate:
        _learnedCount = (_rules.length * provider.grammarProgress / 100)
            .round();
        break;
      case Level.advanced:
        _learnedCount = (_rules.length * provider.grammarProgress / 100)
            .round();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF44336), Color(0xFFD32F2F)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _rules.isEmpty
                    ? Center(
                        child: Text(
                          'No hay reglas disponibles',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : _buildRuleCard(),
              ),
              _buildProgressBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gramática',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.level.name,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${_currentIndex + 1}/${_rules.length}',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRuleCard() {
    final rule = _rules[_currentIndex];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFFF44336).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      rule.title,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF44336),
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      context.read<TtsProvider>().speak(rule.example);
                    },
                    icon: Icon(Icons.volume_up, color: Color(0xFFF44336)),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Explicación',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8),
              Text(
                rule.explanation,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xFFF44336).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Color(0xFFF44336).withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ejemplo',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFF44336),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      rule.example,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      rule.exampleTranslation,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      rule.isLearned = !rule.isLearned;
                      if (rule.isLearned) {
                        _learnedCount++;
                      } else {
                        _learnedCount--;
                      }
                      _updateProgress();
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    decoration: BoxDecoration(
                      color: rule.isLearned
                          ? Color(0xFF4CAF50)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          rule.isLearned
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          rule.isLearned
                              ? 'Aprendido'
                              : 'Marcar como aprendido',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = _rules.isEmpty
        ? 0
        : (_learnedCount / _rules.length * 100).round();
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$_learnedCount reglas aprendidas',
                style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
              ),
              Text(
                '$progress%',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                onPressed: _currentIndex > 0
                    ? () => setState(() => _currentIndex--)
                    : null,
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              Expanded(
                child: Slider(
                  value: _currentIndex.toDouble(),
                  min: 0,
                  max: (_rules.length - 1).toDouble(),
                  activeColor: Colors.white,
                  inactiveColor: Colors.white30,
                  onChanged: (value) =>
                      setState(() => _currentIndex = value.round()),
                ),
              ),
              IconButton(
                onPressed: _currentIndex < _rules.length - 1
                    ? () => setState(() => _currentIndex++)
                    : null,
                icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _updateProgress() {
    final progress = (_learnedCount / _rules.length * 100).round();
    final provider = context.read<ProgressProvider>();
    provider.updateGrammarProgress(progress);
  }
}
