import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/shopper_controller.dart';
import 'package:projeto_de_sistemas/screens/components/button.dart';
import 'package:provider/provider.dart';

class AcceptOrderScreen extends StatelessWidget {
  final SeparationTask task;

  const AcceptOrderScreen({super.key, required this.task});

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
        title: Text("Aceitar pedido #${task.orderId}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/market_image_placeholder.jpg"),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "Novo pedido para separar para ${task.customerName}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "R\$12,90", // NOTA: Este valor precisa vir da sua 'task'.
                    // Adicione um campo de preço ao seu modelo SeparationTask!
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "• Para: Agora",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "• Total de itens: ${task.items.fold(0, (sum, item) => sum + item.quantidade)} unidades",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "• Endereço do cliente: ${task.deliveryAddress}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "• Cliente: ${task.customerName}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: Button(
                      onPressed: () {
                        final shopperController =
                            Provider.of<ShopperController>(
                              context,
                              listen: false,
                            );
                        shopperController.acceptTask(task);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Pedido #${task.orderId} aceito! Notificando entregadores.",
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );

                        Navigator.of(context).pop();
                      },
                      text: "Aceitar e Iniciar Separação",
                      color: const Color.fromARGB(255, 228, 35, 35),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
