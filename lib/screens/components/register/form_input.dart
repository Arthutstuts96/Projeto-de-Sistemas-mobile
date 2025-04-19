import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  const FormInput({super.key, required this.label, required this.placeholder, this.type = TextInputType.text, required this.controller, this.isPassword = false});
  final String label;
  final String placeholder;
  final TextInputType type;
  final TextEditingController controller;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,      
      keyboardType: type,
      obscureText: isPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text(label),
        // errorText: "Não pode ser null",
        hintText: placeholder,
      ),
    );
  }
}