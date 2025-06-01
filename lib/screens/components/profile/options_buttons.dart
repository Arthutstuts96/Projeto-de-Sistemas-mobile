import 'package:flutter/material.dart';

class OptionsButtons extends StatelessWidget {
  const OptionsButtons({
    super.key,
    required this.text,
    required this.icon,
    this.onClick,
    this.color = Colors.black,
  });

  final String text;
  final IconData icon;
  final Function? onClick;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        alignment: Alignment.centerLeft, 
      ),
      onPressed: () {
        if (onClick != null) {
          onClick!();
        }
      },
      child: Row(
        spacing: 20,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32, color: color),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
