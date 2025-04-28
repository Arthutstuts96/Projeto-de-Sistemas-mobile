import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), backgroundColor: Colors.orange),
      body: Center(
        child: Image.asset('assets/images/background.png', fit: BoxFit.contain),
      ),
    );
  }
}
