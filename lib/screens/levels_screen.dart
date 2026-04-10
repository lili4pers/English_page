import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/level.dart';
import '../providers/progress_provider.dart';
import 'vocabulary_screen.dart';
import 'verbs_screen.dart';
import 'adjectives_screen.dart';
import 'grammar_screen.dart';

class LevelsScreen extends StatelessWidget {
  final String category;

  const LevelsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _getCategoryTitle(),
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    _buildLevelCard(
                      context,
                      Level.beginner,
                      'Principiante',
                      '0% - 33%',
                      'Aprende las bases del inglés',
                      Icons.school,
                      Color(0xFF4CAF50),
                    ),
                    SizedBox(height: 15),
                    _buildLevelCard(
                      context,
                      Level.intermediate,
                      'Intermedio',
                      '34% - 66%',
                      'Expande tu conocimiento',
                      Icons.trending_up,
                      Color(0xFFFF9800),
                    ),
                    SizedBox(height: 15),
                    _buildLevelCard(
                      context,
                      Level.advanced,
                      'Avanzado',
                      '67% - 100%',
                      'Domina el inglés',
                      Icons.emoji_events,
                      Color(0xFFF44336),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getCategoryTitle() {
    switch (category) {
      case 'vocabulary':
        return 'Vocabulario';
      case 'verbs':
        return 'Verbos';
      case 'adjectives':
        return 'Adjetivos';
      case 'grammar':
        return 'Gramática';
      default:
        return 'Categoría';
    }
  }

  Widget _buildLevelCard(
    BuildContext context,
    Level level,
    String title,
    String percentage,
    String description,
    IconData icon,
    Color color,
  ) {
    return Consumer<ProgressProvider>(
      builder: (context, provider, child) {
        int progress = _getProgress(provider, level);

        return GestureDetector(
          onTap: () => _navigateToLesson(context, level),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(icon, color: color, size: 30),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                          Text(
                            percentage,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: color, size: 20),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress / 100,
                    backgroundColor: color.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 8,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '$progress% completado',
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int _getProgress(ProgressProvider provider, Level level) {
    switch (category) {
      case 'vocabulary':
        return provider.vocabularyProgress;
      case 'verbs':
        return provider.verbsProgress;
      case 'adjectives':
        return provider.adjectivesProgress;
      case 'grammar':
        return provider.grammarProgress;
      default:
        return 0;
    }
  }

  void _navigateToLesson(BuildContext context, Level level) {
    Widget screen;
    switch (category) {
      case 'vocabulary':
        screen = VocabularyScreen(level: level);
        break;
      case 'verbs':
        screen = VerbsScreen(level: level);
        break;
      case 'adjectives':
        screen = AdjectivesScreen(level: level);
        break;
      case 'grammar':
        screen = GrammarScreen(level: level);
        break;
      default:
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
