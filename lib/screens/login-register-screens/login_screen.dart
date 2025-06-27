import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/components/register/button.dart';
import 'package:projeto_de_sistemas/screens/login-register-screens/register_user_screen.dart';
import 'package:projeto_de_sistemas/utils/consts.dart';
import 'package:projeto_de_sistemas/utils/functions/login_validation.dart';
import 'package:flutter/services.dart';
import 'package:projeto_de_sistemas/controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _loginController = LoginController();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String loginType = "client";

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFFFAA00),
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 159, 10),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/backgrounded.png",
                  fit: BoxFit.cover,
                ),
              ),

              // BOTÃO ESCOLHER TIPO DE LOGIN
              Positioned(
                top: 8,
                right: 0,
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: const Text("Escolha como quer entrar"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RadioListTile<String>(
                                    title: const Text("Cliente"),
                                    value: "client",
                                    groupValue: loginType,
                                    onChanged: (value) {
                                      setState(() {
                                        loginType = value!;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RadioListTile<String>(
                                    title: const Text("Separador"),
                                    value: "shopper",
                                    groupValue: loginType,
                                    onChanged: (value) {
                                      setState(() {
                                        loginType = value!;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RadioListTile<String>(
                                    title: const Text("Entregador"),
                                    value: "delivery",
                                    groupValue: loginType,
                                    onChanged: (value) {
                                      setState(() {
                                        loginType = value!;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                              actions: [
                                Button(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  text: "Cancelar",
                                  color: Colors.redAccent,
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFAA00),
                      border: Border.all(color: Color(0xFFC07C00), width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "Trocar login",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
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
                            "assets/images/girl/logo_login.png",
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
                                  color: Color(0xFFFFAA00),
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
                                      color: Color(0xFFFFAA00),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      width: 3.0,
                                      color: Color(0xFFFFAA00),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      width: 3.0,
                                      color: Colors.red,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      width: 3.0,
                                      color: Color(0xFFFFAA00),
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
                                      color: Color(0xFFFFAA00),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      width: 3.0,
                                      color: Color(0xFFFFAA00),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      width: 3.0,
                                      color: Colors.red,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      width: 3.0,
                                      color: Color(0xFFFFAA00),
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
                                          Map<String, dynamic> result = {
                                            'success': false,
                                            'error': 'Tipo de login inválido.',
                                            'redirect': 'main_screen',
                                          };

                                          switch (loginType) {
                                            case "client":
                                              result = await _loginController
                                                  .loginClientUser(
                                                    email:
                                                        _emailController.text
                                                            .trim(),
                                                    password:
                                                        _passwordController
                                                            .text,
                                                  );
                                              result['redirect'] =
                                                  'main_screen';
                                              break;

                                            case "shopper":
                                              result = await _loginController
                                                  .loginShopperUser(
                                                    email:
                                                        _emailController.text
                                                            .trim(),
                                                    password:
                                                        _passwordController
                                                            .text,
                                                  );
                                              result['redirect'] =
                                                  'main_shopper_screen';
                                              break;

                                            case "delivery":
                                              result = await _loginController
                                                  .loginDeliveryUser(
                                                    email:
                                                        _emailController.text
                                                            .trim(),
                                                    password:
                                                        _passwordController
                                                            .text,
                                                  );
                                              result['redirect'] =
                                                  'delivery_screen';
                                              break;
                                          }
                                          print(result);
                                          if (result['success'] == true) {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              result['redirect'],
                                            );
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  result['error'] ??
                                                      'Erro desconhecido',
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            const WidgetStatePropertyAll(
                                              Color(0xFFFFAA00),
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
                                              color: Color(0xFFFFAA00),
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
                                        color: Color(0xFFFFAA00),
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
