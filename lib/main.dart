import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/splash_screen.dart';
import 'package:projeto_de_sistemas/screens/login_screen.dart';
import 'package:projeto_de_sistemas/screens/home_screen.dart';
import 'package:projeto_de_sistemas/screens/main_screen.dart';


void main() {
  runApp(const TrazAi());
}

class TrazAi extends StatelessWidget {
  const TrazAi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "splash_screen": (context) => const SplashScreen(),
        "login_screen": (context) =>  LoginScreen(),
        "home_screen": (context) =>  HomeScreen(),
        "main_screen": (context) =>  MainScreen(),
      },
      initialRoute: "splash_screen",
    );
  }
}
