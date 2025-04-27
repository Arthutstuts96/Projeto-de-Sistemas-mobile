import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "splash_screen": (context) => const SplashScreen(),
      },
      initialRoute: "splash_screen",
    );
  }
}
