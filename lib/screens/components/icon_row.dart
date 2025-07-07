import 'package:flutter/material.dart';

class IconRow extends StatelessWidget {
  const IconRow({super.key, required this.title, required this.icon});
  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Row(spacing: 4, children: [icon, Text(title)]);
  }
}
