import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/components/products/cart_product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFAA00),
        title: Text(
          "Seu carrinho",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.credit_card)),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(8),
            children: const <Widget>[
              CartProduct(),
              CartProduct(),
              CartProduct(),
              CartProduct(),
              CartProduct(),
              CartProduct(),
              CartProduct(),
              SizedBox(height: 100,)
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.1, // altura inicial (10% da tela)
            minChildSize: 0.1, // altura mínima
            maxChildSize: 0.6, // altura máxima ao expandir
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Center(
                      child: Icon(Icons.drag_handle, color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Resumo do Pedido",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text("Subtotal: R\$ 100,00"),
                    const Text("Entrega: R\$ 10,00"),
                    const SizedBox(height: 10),
                    const Text(
                      "Total: R\$ 110,00",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 42,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.green),
                        shadowColor: WidgetStatePropertyAll(Colors.black),
                        elevation: WidgetStatePropertyAll(
                          8,
                        ), // quanto maior, mais sombra
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      child: const Text("Finalizar pedido", style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
