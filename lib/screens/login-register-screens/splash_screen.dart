import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/login-register-screens/choose_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> { 
  int duration = 2;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: duration)).then((_) {
      if (mounted) {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => ChooseScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12,
          children: [
            Image.asset("assets/images/logo.png", width: 280),
            CircularProgressIndicator(color: Colors.orange),
            Text(
              "Preparando o melhor para você",
              style: TextStyle(color: Colors.orangeAccent, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
