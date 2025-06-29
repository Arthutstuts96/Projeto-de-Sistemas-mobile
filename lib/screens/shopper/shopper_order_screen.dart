import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/domain/models/order/deliver_data.dart';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';
import 'package:projeto_de_sistemas/domain/models/order/order_item.dart';
import 'package:projeto_de_sistemas/screens/components/icon_row.dart';
import 'package:projeto_de_sistemas/screens/components/shopper/order/order_details_unchecked.dart';

class ShopperOrderScreen extends StatefulWidget {
  const ShopperOrderScreen({super.key});

  @override
  State<ShopperOrderScreen> createState() => _ShopperOrderScreenState();
}

class _ShopperOrderScreenState extends State<ShopperOrderScreen> {
  //TODO: pegar uma ordem real
  Order? order = Order(
    numeroPedido: "ORDER_342343414",
    statusPagamento: "pendente",
    statusPedido: "pendente",
    valorTotal: 213.32,
    criadoEm: DateTime.now(),
    descricao: "Quero as bananas verdes!",
    itens: [
      OrderItem(quantidade: 1, precoUnitario: 10.00, disponibilidade: true),
      OrderItem(quantidade: 1, precoUnitario: 5.00, disponibilidade: true),
      OrderItem(quantidade: 1, precoUnitario: 10.00, disponibilidade: false),
    ],
    dadosEntrega: DeliverData(pedidoId: 0, tipoVeiculo: "", enderecoId: 0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 35, 35),
        foregroundColor: Colors.white,
        title: const Text(
          "Pedido atual",
          style: TextStyle(fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_outlined, size: 28),
            tooltip: "Histórico de pedidos",
            onPressed: () {},
          ),
        ],
      ),
      body:
          order == null
              ? const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "Você não está separando nenhum pedido no momento",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
              )
              : Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Informações do pedido",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Separando o pedido #${order!.numeroPedido}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const IconRow(
                          title: "Cliente: Null",
                          icon: Icon(Icons.person_outline, size: 20),
                        ),
                        const SizedBox(height: 6),
                        IconRow(
                          title:
                              "Ativo desde: ${order!.criadoEm.toLocal().toString()}",
                          icon: const Icon(Icons.timer_outlined, size: 20),
                        ),
                        const SizedBox(height: 6),
                        const IconRow(
                          title: "Comentário do cliente:",
                          icon: Icon(Icons.chat_outlined, size: 20),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(255, 232, 239, 255),
                          ),
                          child: Text(
                            order?.descricao ?? "Sem descrição",
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: OrderDetailsUnchecked(order: order),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
    );
  }
}
