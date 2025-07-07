import 'package:flutter/material.dart';

class BuildActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;

  const BuildActionButton({
  super.key,
  required this.label,
  required this.onPressed,
  this.color,
});

@override
Widget build(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color ?? Theme.of(context).primaryColor,
      minimumSize: const Size(double.infinity, 50),
      padding: const EdgeInsets.symmetric(vertical: 16),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    onPressed: onPressed,
    child: Text(label, style: const TextStyle(color: Colors.white)),
  );
}
}