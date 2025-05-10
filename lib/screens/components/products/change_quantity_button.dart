import 'package:flutter/material.dart';

class ChangeQuantityButton extends StatelessWidget {
  ChangeQuantityButton({super.key, required this.quantity});
  int quantity;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, 
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFD9D9D9),
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCircleButton(
              icon: Icons.add,
              color: const Color(0xFFAEAEAE),
              onTap: () {},
            ),
            const SizedBox(width: 8),
            Text("$quantity"),
            const SizedBox(width: 8),
            _buildCircleButton(
              icon: Icons.remove,
              color: const Color(0xFFAEAEAE),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: color,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
