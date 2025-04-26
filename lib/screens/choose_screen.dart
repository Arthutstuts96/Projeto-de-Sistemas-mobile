import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/components/register/button.dart';
import 'package:projeto_de_sistemas/screens/register_user.dart';
import 'package:projeto_de_sistemas/utils/consts.dart';
import 'package:url_launcher/url_launcher.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 44,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 24,
                children: [
                  Text(
                    "Vamos começar do começo",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 52,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "Com qual dessas categorias você se enquadra?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      RegisterUser(userType: UserTypes.client),
                            ),
                          );
                        },
                        child: Ink(
                          width: 170,
                          height: 170,
                          decoration: BoxDecoration(
                            color: Color(0xFFBFBFBF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person, size: 88),
                              Text(
                                "Quero pedir minhas compras",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
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
                                      RegisterUser(userType: UserTypes.worker),
                            ),
                          );
                        },
                        child: Ink(
                          width: 170,
                          height: 170,
                          decoration: BoxDecoration(
                            color: Color(0xFFBFBFBF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.motorcycle, size: 88),
                              Text(
                                "Quero trabalhar com entregas/separador",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Button(
                      onPressed: () {},
                      text: "Já tenho uma conta",
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
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
                            launchUrl(Uri.parse('https://www.google.com'));
                          },
                  ),
                ],
              ),
            ),
            SizedBox(height: 4)
          ],
        ),
      ),
    );
  }
}
