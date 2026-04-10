import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/progress_provider.dart';
import '../providers/tts_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
              _buildHeader(context),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    _buildSectionTitle('Configuración de Audio'),
                    _buildAudioSettings(context),
                    SizedBox(height: 30),
                    _buildSectionTitle('Progreso'),
                    _buildProgressSettings(context),
                    SizedBox(height: 30),
                    _buildSectionTitle('Acerca de'),
                    _buildAboutSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          SizedBox(width: 10),
          Text(
            'Configuración',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildAudioSettings(BuildContext context) {
    return Consumer<TtsProvider>(
      builder: (context, ttsProvider, child) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Velocidad del habla',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  Text(
                    '${(ttsProvider.speechRate * 100).round()}%',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Slider(
                value: ttsProvider.speechRate,
                min: 0.1,
                max: 1.0,
                activeColor: Color(0xFF667eea),
                onChanged: (value) => ttsProvider.setSpeechRate(value),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tono de voz', style: GoogleFonts.poppins(fontSize: 14)),
                  Text(
                    '${(ttsProvider.pitch * 100).round()}%',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Slider(
                value: ttsProvider.pitch,
                min: 0.5,
                max: 2.0,
                activeColor: Color(0xFF667eea),
                onChanged: (value) => ttsProvider.setPitch(value),
              ),
              SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () => ttsProvider.speak('Hello, this is a test.'),
                icon: Icon(Icons.volume_up),
                label: Text('Probar audio'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF667eea),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgressSettings(BuildContext context) {
    return Consumer<ProgressProvider>(
      builder: (context, progressProvider, child) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              _buildProgressRow(
                'Ejercicios completados',
                '${progressProvider.totalExercisesCompleted}',
              ),
              Divider(),
              _buildProgressRow(
                'Tiempo de escucha',
                '${(progressProvider.totalListeningTime / 60).floor()}:${(progressProvider.totalListeningTime % 60).toString().padLeft(2, '0')}',
              ),
              Divider(),
              _buildProgressRow(
                'Progreso general',
                '${progressProvider.overallProgress}%',
              ),
              SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () => _showResetDialog(context, progressProvider),
                icon: Icon(Icons.refresh, color: Colors.red),
                label: Text(
                  'Reiniciar progreso',
                  style: TextStyle(color: Colors.red),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgressRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 14)),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF667eea),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'English Learn App',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Versión 1.0.0',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(height: 15),
          Text(
            'Aprende inglés por niveles con vocabulario, verbos, adjetivos y gramática. Mejora tu pronunciación con nuestra función de texto a voz.',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context, ProgressProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('¿Reiniciar progreso?'),
        content: Text(
          'Esto borrará todo tu progreso guardado. Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              provider.resetProgress();
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Progreso reiniciado')));
            },
            child: Text('Reiniciar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
