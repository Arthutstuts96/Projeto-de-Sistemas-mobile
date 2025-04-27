import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    super.key,
    required this.label,
    required this.placeholder,
    this.type = TextInputType.text,
    required this.controller,
    this.isPassword = false,
    this.validator,
  });

  final String label;
  final String placeholder;
  final TextInputType type;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator; // Aqui mudamos para uma função

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      validator: (value) {
        if (validator != null) {
          return validator!(value);
        } else {
          if (value == null || value.isEmpty) {
            return "Por favor, preencha o campo";
          }
          return null;
        }
      },     
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text(label),
        hintText: placeholder,
      ),
    );
  }
}
