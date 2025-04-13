import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/ui/login_screen.dart';


void main() {
  runApp(const TrazAi());
}

class TrazAi extends StatelessWidget {
  const TrazAi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "login": (context) => const LoginScreen(),
      },
      initialRoute: "login",
    );
  }
}
