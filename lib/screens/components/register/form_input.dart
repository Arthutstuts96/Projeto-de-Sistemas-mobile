import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  const FormInput({super.key, required this.label, required this.placeholder, this.type = TextInputType.text});
  final String label;
  final String placeholder;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      decoration: InputDecoration(
        label: Text(label),
        hintText: placeholder,
      ),
    );
  }
}