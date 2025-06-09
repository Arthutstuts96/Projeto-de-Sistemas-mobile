import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';

class OrderDetailsUnchecked extends StatelessWidget {
  const OrderDetailsUnchecked({super.key, required this.order});
  final Order? order;

  @override
  Widget build(BuildContext context) {
    if (order == null || order!.itens.isEmpty) {
      return const Center(child: Text('Não há mais nenhum item a separar'));
    }

    return Container(
      color: const Color.fromARGB(255, 219, 206, 165),
      child: Column(
        children: [
          const Text(
            "Detalhes do Pedido:", 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8), 
          Expanded(
            child: ListView.builder(
              itemCount: order!.itens.length,
              itemBuilder: (context, index) {
                final item = order!.itens[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Produto ID: ${item.produtoId}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Quantidade: ${item.quantidade}'),
                          Text(
                            'Preço Unitário: R\$ ${item.precoUnitario.toStringAsFixed(2)}',
                          ),
                          Text(
                            'Disponibilidade: ${item.disponibilidade ? "Disponível" : "Indisponível"}',
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
