import 'package:flutter/material.dart';

class ChangeQuantityButton extends StatelessWidget {
  const ChangeQuantityButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xFFD9D9D9),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          spacing: 8,
          children: [
            InkWell(
              onTap: () {},
              child: Ink(
                decoration: BoxDecoration(
                  color: Color(0xFFB370FF),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(Icons.add),
              ),
            ),
            Text("1"),
            InkWell(
              onTap: () {},
              child: Ink(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 96, 3, 202),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(Icons.remove),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
