import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/lesson_data.dart';
import '../models/verb.dart';
import '../models/level.dart';
import '../providers/progress_provider.dart';
import '../providers/tts_provider.dart';
import '../widgets/flash_card.dart';

class VerbsScreen extends StatefulWidget {
  final Level level;

  const VerbsScreen({super.key, required this.level});

  @override
  State<VerbsScreen> createState() => _VerbsScreenState();
}

class _VerbsScreenState extends State<VerbsScreen> {
  late List<Verb> _verbs;
  int _currentIndex = 0;
  int _learnedCount = 0;

  @override
  void initState() {
    super.initState();
    _verbs = LessonData.getVerbs(widget.level.name.toLowerCase());
    _loadProgress();
  }

  void _loadProgress() {
    final provider = context.read<ProgressProvider>();
    switch (widget.level) {
      case Level.beginner:
        _learnedCount = (_verbs.length * provider.verbsProgress / 100).round();
        break;
      case Level.intermediate:
        _learnedCount = (_verbs.length * provider.verbsProgress / 100).round();
        break;
      case Level.advanced:
        _learnedCount = (_verbs.length * provider.verbsProgress / 100).round();
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
            colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _verbs.isEmpty
                    ? Center(
                        child: Text(
                          'No hay verbos disponibles',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : _buildVerbCard(),
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
                  'Verbos',
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
              '${_currentIndex + 1}/${_verbs.length}',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerbCard() {
    final verb = _verbs[_currentIndex];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: FlashCard(
        front: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              verb.baseForm,
              style: GoogleFonts.poppins(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              verb.pronunciation,
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.white70),
            ),
            SizedBox(height: 20),
            Text(
              verb.spanish,
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
                    context.read<TtsProvider>().speak(verb.baseForm);
                  },
                ),
                SizedBox(width: 15),
                _buildActionButton(
                  icon: verb.isLearned
                      ? Icons.check_circle
                      : Icons.check_circle_outline,
                  label: 'Aprendido',
                  color: verb.isLearned ? Color(0xFF4CAF50) : Colors.white,
                  onTap: () {
                    setState(() {
                      verb.isLearned = !verb.isLearned;
                      if (verb.isLearned) {
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
              'Conjugaciones',
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white70),
            ),
            SizedBox(height: 15),
            _buildConjugationRow('Presente', verb.baseForm),
            SizedBox(height: 10),
            _buildConjugationRow('Pasado', verb.pastSimple),
            SizedBox(height: 10),
            _buildConjugationRow('Participio', verb.pastParticiple),
          ],
        ),
      ),
    );
  }

  Widget _buildConjugationRow(String label, String value) {
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
    final progress = _verbs.isEmpty
        ? 0
        : (_learnedCount / _verbs.length * 100).round();
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$_learnedCount verbos aprendidos',
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
                  max: (_verbs.length - 1).toDouble(),
                  activeColor: Colors.white,
                  inactiveColor: Colors.white30,
                  onChanged: (value) =>
                      setState(() => _currentIndex = value.round()),
                ),
              ),
              IconButton(
                onPressed: _currentIndex < _verbs.length - 1
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
    final progress = (_learnedCount / _verbs.length * 100).round();
    final provider = context.read<ProgressProvider>();
    provider.updateVerbsProgress(progress);
  }
}
