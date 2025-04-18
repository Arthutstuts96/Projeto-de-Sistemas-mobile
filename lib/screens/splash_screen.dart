import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/choose_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  /* 
    Tela placeholder, implementar ela depois
  */
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Splash screen do Aplicativo"),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChooseScreen()),
                );
              },
              child: Text("Entrar na aplicação"),
            ),
          ],
        ),
      ),
    );
  }
}
