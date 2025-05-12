import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/register_user_screen.dart';
import 'package:projeto_de_sistemas/utils/consts.dart';
import 'package:projeto_de_sistemas/utils/functions/login_validation.dart';
import 'package:flutter/services.dart';
import 'package:projeto_de_sistemas/controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController _loginController = LoginController();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 255, 152, 0),
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 159, 10),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/background.png",
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Transform.translate(
                          offset: const Offset(0, -45),
                          child: Image.asset(
                            "assets/images/logo_login.png",
                            height: 300,
                            width: 300,
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Bem vindo",
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Leckerli One",
                                  color: Color(0xFFC07C00),
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: validateLoginEmail,
                                decoration: InputDecoration(
                                  labelText:
                                      "E-mail", // Colocando o texto como label
                                  hintText: "seu@email.com",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      width: 3.0,
                                      color: Color(0xFFC07C00),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      width: 3.0,
                                      color: Color(0xFFC07C00),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 22),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                validator: validateLoginPassword,
                                decoration: InputDecoration(
                                  labelText:
                                      "Senha", // Colocando o texto como label
                                  hintText: "Sua senha",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      width: 3.0,
                                      color: Color(0xFFC07C00),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      width: 3.0,
                                      color: Color(0xFFC07C00),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          final result = await _loginController
                                              .loginUser(
                                                email:
                                                    _emailController.text
                                                        .trim(),
                                                password:
                                                    _passwordController.text,
                                              );
                                          if (result['success']) {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              'main_screen',
                                            );
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(result['error']),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            const WidgetStatePropertyAll(
                                              Color(0xFFC07C00),
                                            ),
                                        minimumSize:
                                            const WidgetStatePropertyAll(
                                              Size(380, 50),
                                            ),
                                        shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            side: const BorderSide(
                                              color: Color(0xFFC07C00),
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        "Entrar",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    const Text(
                                      "Não possui conta? Crie uma agora",
                                      style: TextStyle(
                                        fontFamily: "poppins",
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                        color: Color.fromARGB(255, 100, 65, 0),
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => RegisterUserScreen(
                                                  userType: UserTypes.client,
                                                ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Color(0xFFC07C00),
                                        minimumSize: const Size(150, 40),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          side: const BorderSide(
                                            color: Color(0xFFC07C00),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        "Criar Conta",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
