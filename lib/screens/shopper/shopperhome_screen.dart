import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/components/page_screen_transition.dart';
import 'package:projeto_de_sistemas/screens/shopper/accept_order_screen.dart';

class ShopperHomeScreen extends StatelessWidget {
  const ShopperHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        title: const Text("Separador • Pedidos"),
        backgroundColor: const Color.fromARGB(255, 228, 35, 35),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
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
                  "Nenhum pedido selecionado",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Aguarde novos pedidos ou selecione um abaixo",
                  style: TextStyle(fontSize: 12, color: Colors.black26),
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
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
                        itemCount: 1,
                        itemBuilder:
                            (context, index) => const OrdersInfos(
                              imagePath:
                                  "assets/images/choose_screen_background.jpg",
                              title: "Supermercado Brasil • 2,5km",
                              priority: "Agora",
                              distance: "2,5 km",
                              itemsCount: 17,
                              estimatedTime: "15-20 min",
                            ),
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
    required this.imagePath,
    required this.title,
    required this.priority,
    required this.distance,
    required this.itemsCount,
    required this.estimatedTime,
  });

  final String imagePath;
  final String title;
  final String priority;
  final String distance;
  final int itemsCount;
  final String estimatedTime;

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
            navigateUsingTransitionFromBelow(const AcceptOrderScreen()),
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
              "$itemsCount itens • $estimatedTime",
              style: const TextStyle(fontSize: 12),
            ),
            Text("Distância: $distance", style: const TextStyle(fontSize: 12)),
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
