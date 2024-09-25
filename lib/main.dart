import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'injection_container.dart' as di;

import './features/number_trivia/presentation/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green.shade800,
        ),
      ),
      home: const MainScreen(),
    );
  }
}
