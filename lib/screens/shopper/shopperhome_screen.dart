import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/shopper_controller.dart';
import 'package:projeto_de_sistemas/screens/components/page_screen_transition.dart';
import 'package:projeto_de_sistemas/screens/components/shopper/active_task_card.dart';
import 'package:projeto_de_sistemas/screens/shopper/accept_order_screen.dart';
import 'package:provider/provider.dart';

class ShopperHomeScreen extends StatelessWidget {
  const ShopperHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shopperController = context.watch<ShopperController>();
    final tasks = shopperController.tasks;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        title: const Text("Separador • Pedidos"),
        backgroundColor: const Color.fromARGB(255, 228, 35, 35),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),

      body:
          shopperController.activeTask != null
              ? ActiveTaskCard(task: shopperController.activeTask!)
              : Stack(
                children: [
                  if (tasks.isEmpty)
                    const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: Color.fromARGB(40, 76, 175, 80),
                            child: Icon(
                              Icons.inventory_2_rounded,
                              size: 60,
                              color: Color.fromARGB(100, 56, 142, 60),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Nenhum pedido disponível",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black38,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Aguardando novas solicitações de compra...",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black26,
                            ),
                          ),
                        ],
                      ),
                    ),

                  DraggableScrollableSheet(
                    initialChildSize: 0.3,
                    minChildSize: 0.3,
                    maxChildSize: 0.85,
                    builder: (context, scrollController) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 8),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                width: 50,
                                height: 6,
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const Text(
                              "Pedidos disponíveis",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Expanded(
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: tasks.length,
                                itemBuilder: (context, index) {
                                  if (tasks.isEmpty) {
                                    if (shopperController.activeTask != null) {
                                      return const Center(
                                        child: Text(
                                          "Você já está separando um pedido, termine-o antes de aceitar o próximo",
                                        ),
                                      );
                                    }
                                    return const Center(
                                      child: Text(
                                        "Não há nenhum pedido disponível no momento",
                                      ),
                                    );
                                  }
                                  final task = tasks[index];

                                  return OrdersInfos(
                                    task: task,
                                    imagePath:
                                        "assets/images/market_image_placeholder.jpg",
                                    title: "Pedido #${task.orderId}",
                                    priority: "Agora",
                                    distance: "2,5 km",
                                    itemsSummary:
                                        task.description ?? "Sem descrição",
                                  );
                                },
                              ),
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

class OrdersInfos extends StatelessWidget {
  const OrdersInfos({
    super.key,
    required this.task,
    required this.imagePath,
    required this.title,
    required this.priority,
    required this.distance,
    required this.itemsSummary,
  });

  final SeparationTask task;
  final String imagePath;
  final String title;
  final String priority;
  final String distance;
  final String itemsSummary;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        onTap: () {
          Navigator.push(
            context,
            navigateUsingTransitionFromBelow(AcceptOrderScreen(task: task)),
          );
        },
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(
            imagePath,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              itemsSummary,
              style: const TextStyle(fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Cliente: ${task.customerName}",
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Chip(
              label: Text(
                priority,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor:
                  priority == "URGENTE"
                      ? Colors.redAccent
                      : Colors.orangeAccent,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
          ],
        ),
      ),
    );
  }
}
