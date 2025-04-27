import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/splash_screen.dart';
import 'package:projeto_de_sistemas/screens/login_screen.dart';


void main() {
  runApp(const TrazAi());
}

class TrazAi extends StatelessWidget {
  const TrazAi({super.key});

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
