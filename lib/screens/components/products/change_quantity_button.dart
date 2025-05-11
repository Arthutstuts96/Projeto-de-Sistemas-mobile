import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChangeQuantityButton extends StatefulWidget {
  ChangeQuantityButton({super.key, required this.quantity});
  int quantity;

  @override
  State<ChangeQuantityButton> createState() => _ChangeQuantityButtonState();
}

class _ChangeQuantityButtonState extends State<ChangeQuantityButton> {
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
              onTap: () {
                setState(() {
                  widget.quantity++;
                });
              },
            ),
            const SizedBox(width: 8),
            Text("${widget.quantity}"),
            const SizedBox(width: 8),
            _buildCircleButton(
              icon: Icons.remove,
              color: const Color(0xFFAEAEAE),
              onTap: () {
                setState(() {
                  if(widget.quantity > 1){
                    widget.quantity--;
                  }
                });
              },
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
