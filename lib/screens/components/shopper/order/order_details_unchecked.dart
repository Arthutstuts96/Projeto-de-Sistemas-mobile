import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';

class OrderDetailsUnchecked extends StatelessWidget {
  const OrderDetailsUnchecked({super.key, required this.order});
  final Order? order;

  @override
  Widget build(BuildContext context) {
    if (order == null || order!.itens.isEmpty) {
      return const Center(
        child: Text(
          'Não há mais nenhum item a separar',
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFF8DC), // cor tipo "folha amarelada"
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Detalhes do Pedido",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(thickness: 1.5),
          Expanded(
            child: ListView.separated(
              itemCount: order!.itens.length,
              separatorBuilder:
                  (_, __) => const Divider(
                    thickness: 1,
                    color: Color.fromARGB(255, 184, 149, 136),
                    indent: 16,
                    endIndent: 16,
                  ),
              itemBuilder: (context, index) {
                final item = order!.itens[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 16.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(6, 6),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: CircleAvatar(
                        backgroundColor: Colors.brown.shade100,
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                        'Produto: ${item.produtoId}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: 'PatrickHand',
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quantidade: ${item.quantidade}',
                            style: const TextStyle(fontFamily: 'PatrickHand'),
                          ),
                          Text(
                            'Preço Unitário: R\$ ${item.precoUnitario.toStringAsFixed(2)}',
                            style: const TextStyle(fontFamily: 'PatrickHand'),
                          ),
                          Text(
                            'Disponível: ${item.disponibilidade ? "Sim" : "Não"}',
                            style: TextStyle(
                              color:
                                  item.disponibilidade
                                      ? Colors.green
                                      : Colors.red,
                            ),
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
