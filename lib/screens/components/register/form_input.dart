import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  const FormInput({super.key, required this.label, required this.placeholder, this.type = TextInputType.text, required this.controller});
  final String label;
  final String placeholder;
  final TextInputType type;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,      
      keyboardType: type,
      decoration: InputDecoration(
        label: Text(label),
        // errorText: "Não pode ser null",
        hintText: placeholder,
      ),
    );
  }
}