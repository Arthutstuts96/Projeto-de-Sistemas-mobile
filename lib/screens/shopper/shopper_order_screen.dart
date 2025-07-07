import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Ótimo para formatar datas
import 'package:projeto_de_sistemas/controllers/shopper_controller.dart';
import 'package:projeto_de_sistemas/screens/components/icon_row.dart';
import 'package:projeto_de_sistemas/screens/components/shopper/order/finalize_separation_fab.dart';
import 'package:projeto_de_sistemas/screens/components/shopper/order/order_details_unchecked.dart';
import 'package:provider/provider.dart';

// MUDANÇA: Convertido para StatelessWidget, pois o estado é gerenciado pelo Provider
class ShopperOrderScreen extends StatelessWidget {
  const ShopperOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // MUDANÇA: Ouvindo o ShopperController para obter a tarefa ativa
    final shopperController = context.watch<ShopperController>();
    final activeTask = shopperController.activeTask;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 35, 35),
        foregroundColor: Colors.white,
        title: const Text("Pedido atual", style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_outlined, size: 28),
            tooltip: "Histórico de pedidos",
            onPressed: () {},
          ),
        ],
      ),
      // MUDANÇA: A lógica agora verifica se 'activeTask' é nulo
      body:
          activeTask == null
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
                          "Separando o pedido #${activeTask.orderId}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        IconRow(
                          title: "Cliente: ${activeTask.customerName}",
                          icon: const Icon(Icons.person_outline, size: 20),
                        ),
                        const SizedBox(height: 6),
                        IconRow(
                          title:
                              "Ativo desde: ${DateFormat('dd/MM/yy HH:mm').format(activeTask.criadoEm.toLocal())}",
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
                            activeTask.description ?? "Sem comentários.",
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
                      child: OrderDetailsUnchecked(items: activeTask.items),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(8.0),
        child: FinalizeSeparationFAB(),
      ),
    );
  }
}
