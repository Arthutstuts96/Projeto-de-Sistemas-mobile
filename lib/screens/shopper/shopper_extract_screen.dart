import 'package:flutter/material.dart';

class ShopperExtractScreen extends StatelessWidget {
  const ShopperExtractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: const EdgeInsets.symmetric(horizontal: 8),
        backgroundColor: const Color.fromARGB(255, 228, 35, 35),
        title: const Text(
          "Extrato",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        spacing: 12,
        children: [
          const SizedBox(height: 4),
          const Text(
            "Acompanhe seu desempenho por aqui, Separadilson",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Row(
            spacing: 24,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/girl/girl_shopper_concentrated.png",
                width: 120,
              ),
              const Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    SizedBox(height: 12),
                    Text(
                      "Ganhos desse mês:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("• Total ganho: R\$12,12"),
                    Text("• Pedidos totais separados: 32"),
                    Text("• Mercados visitados: 4"),
                    Text("• Avaliações positivas: 28"),
                    SizedBox(height: 12),
                    Text(
                      "Sua avaliação geral diz que você é um ótimo separador. Parabéns!",
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 290,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(255, 228, 35, 35),
          ),
        ],
      ),
    );
  }
}
