import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/components/page_screen_transition.dart';
import 'package:projeto_de_sistemas/screens/shopper/accept_order_screen.dart';

class ShopperHomeScreen extends StatelessWidget {
  const ShopperHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 0.6,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                ),
                child: Column(
                  children: [
                    Center(child: Icon(Icons.drag_handle, color: Colors.grey)),
                    const Text(
                      "Pedidos mais recentes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Flexible(
                      child: ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                        itemCount: 1,
                        itemBuilder:
                            (context, index) => const OrdersInfos(
                              imagePath:
                                  "assets/images/choose_screen_background.jpg",
                              title: "Supermercado Maior • A 4,4km de você",
                              priority: "Para agora",
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
  });
  final String imagePath;
  final String title;
  final String priority;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.push(context, navigateUsingTransitionFromBelow(const AcceptOrderScreen()));
      },
      leading: CircleAvatar(backgroundImage: AssetImage(imagePath)),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(priority),
    );
  }
}
