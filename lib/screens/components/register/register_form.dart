import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key, required this.fields, required this.title, this.icon = Icons.person});
  final List<Widget> fields;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...fields.map((field) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: field,
                )),
          ],
        ),
      ),
    );
  }
}
