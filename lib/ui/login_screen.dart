import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            "assets/images/login_image.png",
            fit: BoxFit.cover, // Ajusta a imagem
            width: double.infinity, // Faz a imagem ocupar toda a largura
          ),
          Expanded(
            child: Container(
              width:
                  double.infinity, // Faz a box ocupar toda a largura disponível
              padding: const EdgeInsets.all(16), // Espaçamento interno da box
              decoration: BoxDecoration(
                color: Colors.white, // Cor de fundo da box
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    16,
                  ), // Apenas o topo esquerdo arredondado
                  topRight: Radius.circular(
                    16,
                  ), // Apenas o topo direito arredondado
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26, // Sombra leve
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Bem vindo ao Traz Aí",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                        color: Color.fromARGB(255, 239, 159, 10),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("E-mail"),
                    ), // Espaçamento entre o texto e os campos
                    TextFormField(),
                    const SizedBox(height: 32),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Senha"),
                    ), // Espaçamento entre os campos
                    TextFormField(obscureText: true),
                    const SizedBox(
                      height: 32,
                    ), // Espaçamento entre o campo e o botão
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, "home");
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              const Color.fromARGB(255, 239, 159, 10),
                            ),
                            minimumSize: WidgetStatePropertyAll(
                              const Size(185, 50),
                            ),
                          ),
                          child: const Text(
                            "Entrar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, "cadastro");
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              const Color.fromARGB(255, 226, 251, 0),
                            ),
                            minimumSize: WidgetStatePropertyAll(
                              const Size(185, 50),
                            ),
                          ),
                          child: const Text(
                            "Cadastro",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
