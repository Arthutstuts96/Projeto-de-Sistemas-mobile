import 'package:flutter/material.dart';

class RegisterTopStyle extends StatelessWidget {
  const RegisterTopStyle({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.only(top: 56)),
              ),
              child: Icon(
                Icons.subdirectory_arrow_left_rounded,
                size: 28,
                color: Color.fromARGB(255, 44, 44, 44),
              ),
            ),
            Image.asset("assets/images/logo.png", width: 280),
          ],
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
