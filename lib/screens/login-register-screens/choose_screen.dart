import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/login-register-screens/login_screen.dart';
import 'package:projeto_de_sistemas/screens/login-register-screens/register_user_screen.dart';
import 'package:projeto_de_sistemas/utils/api_configs.dart';
import 'package:projeto_de_sistemas/utils/consts.dart';
import 'package:url_launcher/url_launcher.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/images/choose_screen_background.jpg"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Text(
              "Vamos começar do começo",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              RegisterUserScreen(userType: UserTypes.client),
                    ),
                  );
                },
                child: Ink(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Quero ser cliente",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              RegisterUserScreen(userType: UserTypes.worker),
                    ),
                  );
                },
                child: Ink(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Quero ser entregador",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 12, right: 12),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: const Text(
                  "Já tenho uma conta",
                  style: TextStyle(
                    color: Color(0xFFFFAA00),
                    fontSize: 16, 
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        "Caso você seja dono de um mercado, entre em contato conosco ",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  TextSpan(
                    text: "clicando aqui",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            //LINK DO BACKEND
                            launchUrl(Uri.parse(ipHost));
                          },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
