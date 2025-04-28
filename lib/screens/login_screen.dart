import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/utils/functions/login_validation.dart'; // ou seu novo arquivo
import 'package:projeto_de_sistemas/controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController _loginController = LoginController();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Image.asset(
              "assets/images/login_image.png",
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
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
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          color: Color.fromARGB(255, 239, 159, 10),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Campo de E-mail com validação
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("E-mail"),
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: validateLoginEmail,
                        decoration: InputDecoration(
                          hintText: "seu@email.com",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Campo de Senha com validação
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Senha"),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: validateLoginPassword,
                        decoration: InputDecoration(
                          hintText: "Sua senha",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final result = await _loginController.loginUser(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text,
                                );

                                if (result['success']) {
                                  // Login bem-sucedido - navegar para home
                                  Navigator.pushReplacementNamed(
                                    context,
                                    'home_screen',
                                  );
                                } else {
                                  // Mostrar erro
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(result['error']),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
