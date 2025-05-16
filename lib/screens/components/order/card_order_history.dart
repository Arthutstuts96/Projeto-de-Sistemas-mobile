import 'package:flutter/material.dart';

class CardOrderHistory extends StatelessWidget {
  const CardOrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text("20/03/2024"),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pedido N°: ABC234",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 2,
                    children: [
                      Text(
                        "Total do pedido",
                        style: TextStyle(fontWeight: FontWeight.w100),
                      ),
                      Text(
                        "R\$24,99",
                        style: TextStyle(fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 2,
                    children: [
                      Text(
                        "Local",
                        style: TextStyle(fontWeight: FontWeight.w100),
                      ),
                      Text(
                        "Supermercado Maior",
                        style: TextStyle(fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 2,
                    children: [
                      Text(
                        "Status do pedido",
                        style: TextStyle(fontWeight: FontWeight.w100),
                      ),
                      Text("Recebido", style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
