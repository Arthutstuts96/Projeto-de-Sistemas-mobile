import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/components/register/form_input.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key, required this.fields, required this.title});
  final List<FormInput> fields;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
      child: Column(
        spacing: 8,
        children: [
          Row(
            spacing: 4,
            children: [
              Icon(Icons.person),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Column(
            spacing: 4,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: fields,
          ),
        ],
      ),
    );
  }
}
