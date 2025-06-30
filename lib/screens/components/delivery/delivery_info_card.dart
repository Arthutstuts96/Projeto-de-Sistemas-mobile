import 'package:flutter/material.dart';

class DeliveryInfoCard extends StatelessWidget {
  final String title;
  final List<String> details;

  const DeliveryInfoCard({
    super.key,
    required this.title,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                details.map((text) {
                  final isCurrency = text.startsWith('R\$');
                  return Text(
                    text,
                    style: TextStyle(
                      fontSize: (isCurrency ? 16 : 14),
                      fontWeight:
                          (isCurrency ? FontWeight.bold : FontWeight.normal),
                      color: Colors.black,
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}