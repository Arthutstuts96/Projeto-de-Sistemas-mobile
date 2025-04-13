import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/images/circle.png"),
          Align(
            alignment: Alignment(0.0, -0.8),
            child: Text(
              "Bem vindo ao Traz Aí",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontFamily: "Lato",
                color: Color.fromARGB(255, 90, 86, 86),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32), // Ajuste o valor do padding aqui
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                const Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32),
                ),
                const SizedBox(height: 32), // Espaçamento entre os widgets
                TextFormField(
                  decoration: InputDecoration(label: Text("Email ou Usuário")),
                ),
                const SizedBox(height: 32), // Espaçamento entre os campos
                TextFormField(
                  decoration: InputDecoration(label: Text("Senha")),
                  obscureText: true,
                ),
                const SizedBox(height: 32), // Espaçamento entre os campos
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "home");
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xFF6DB1FF)),
                    minimumSize: WidgetStatePropertyAll(Size(400, 50)),
                  ),
                  child: const Text(
                    "Entrar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
