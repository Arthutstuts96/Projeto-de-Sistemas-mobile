import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/components/button.dart';

class AcceptOrderScreen extends StatelessWidget {
  const AcceptOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Aceitar pedido"),
      ),
      body: Column(
        children: [
          Image.asset("assets/images/market_image_placeholder.jpg"),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 12,
              children: [
                const Text(
                  "Novo pedido para separar no Supermercado Maior",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "R\$12,90",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Column(     
                  crossAxisAlignment: CrossAxisAlignment.start,    
                  spacing: 4,         
                  children: [
                    Text("• Para: Agora", style: TextStyle(fontSize: 16),),
                    Text("• Total de itens: 12", style: TextStyle(fontSize: 16),),
                    Text(
                      "• Endereço do mercado: Plano Diretor Sul, Quadra 403 Sul, Alameda 17,Lote 34", style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: Button(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Pedido aceito!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    },
                    text: "Aceitar pedido",
                    color: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
