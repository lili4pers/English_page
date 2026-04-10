import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/progress_provider.dart';
import 'providers/tts_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const EnglishLearnApp());
}

class EnglishLearnApp extends StatelessWidget {
  const EnglishLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
        ChangeNotifierProvider(create: (_) => TtsProvider()),
      ],
      child: MaterialApp(
        title: 'English Learn',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xFF667eea),
            brightness: Brightness.light,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
