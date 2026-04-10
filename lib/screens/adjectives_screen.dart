import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/lesson_data.dart';
import '../models/adjective.dart';
import '../models/level.dart';
import '../providers/progress_provider.dart';
import '../providers/tts_provider.dart';
import '../widgets/flash_card.dart';

class AdjectivesScreen extends StatefulWidget {
  final Level level;

  const AdjectivesScreen({super.key, required this.level});

  @override
  State<AdjectivesScreen> createState() => _AdjectivesScreenState();
}

class _AdjectivesScreenState extends State<AdjectivesScreen> {
  late List<Adjective> _adjectives;
  int _currentIndex = 0;
  int _learnedCount = 0;

  @override
  void initState() {
    super.initState();
    _adjectives = LessonData.getAdjectives(widget.level.name.toLowerCase());
    _loadProgress();
  }

  void _loadProgress() {
    final provider = context.read<ProgressProvider>();
    switch (widget.level) {
      case Level.beginner:
        _learnedCount = (_adjectives.length * provider.adjectivesProgress / 100)
            .round();
        break;
      case Level.intermediate:
        _learnedCount = (_adjectives.length * provider.adjectivesProgress / 100)
            .round();
        break;
      case Level.advanced:
        _learnedCount = (_adjectives.length * provider.adjectivesProgress / 100)
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
            colors: [Color(0xFFFF9800), Color(0xFFF57C00)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _adjectives.isEmpty
                    ? Center(
                        child: Text(
                          'No hay adjetivos disponibles',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : _buildAdjectiveCard(),
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
                  'Adjetivos',
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
              '${_currentIndex + 1}/${_adjectives.length}',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdjectiveCard() {
    final adjective = _adjectives[_currentIndex];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: FlashCard(
        front: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              adjective.english,
              style: GoogleFonts.poppins(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              adjective.pronunciation,
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.white70),
            ),
            SizedBox(height: 20),
            Text(
              adjective.spanish,
              style: GoogleFonts.poppins(fontSize: 24, color: Colors.white70),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(
                  icon: Icons.volume_up,
                  label: 'Escuchar',
                  onTap: () {
                    context.read<TtsProvider>().speak(adjective.english);
                  },
                ),
                SizedBox(width: 15),
                _buildActionButton(
                  icon: adjective.isLearned
                      ? Icons.check_circle
                      : Icons.check_circle_outline,
                  label: 'Aprendido',
                  color: adjective.isLearned ? Color(0xFF4CAF50) : Colors.white,
                  onTap: () {
                    setState(() {
                      adjective.isLearned = !adjective.isLearned;
                      if (adjective.isLearned) {
                        _learnedCount++;
                      } else {
                        _learnedCount--;
                      }
                      _updateProgress();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        back: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Grados de comparación',
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white70),
            ),
            SizedBox(height: 15),
            _buildComparisonRow('Positivo', adjective.english),
            SizedBox(height: 10),
            _buildComparisonRow('Comparativo', adjective.comparative),
            SizedBox(height: 10),
            _buildComparisonRow('Superlativo', adjective.superlative),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonRow(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(width: 8),
            Text(label, style: GoogleFonts.poppins(color: color, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = _adjectives.isEmpty
        ? 0
        : (_learnedCount / _adjectives.length * 100).round();
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$_learnedCount adjetivos aprendidos',
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
                  max: (_adjectives.length - 1).toDouble(),
                  activeColor: Colors.white,
                  inactiveColor: Colors.white30,
                  onChanged: (value) =>
                      setState(() => _currentIndex = value.round()),
                ),
              ),
              IconButton(
                onPressed: _currentIndex < _adjectives.length - 1
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
    final progress = (_learnedCount / _adjectives.length * 100).round();
    final provider = context.read<ProgressProvider>();
    provider.updateAdjectivesProgress(progress);
  }
}
