import 'package:flutter/material.dart';
import 'package:couldai_user_app/screens/home_screen.dart';

void main() {
  runApp(const EasyAIApp());
}

class EasyAIApp extends StatelessWidget {
  const EasyAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy AI Control',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Using a high-contrast, friendly color scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3), // Friendly Blue
          primary: const Color(0xFF1565C0),
          secondary: const Color(0xFF4CAF50), // Success Green
          error: const Color(0xFFD32F2F), // Clear Red for Stop/Error
        ),
        useMaterial3: true,
        // enhancing text legibility for non-tech users
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black87),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
      },
    );
  }
}
