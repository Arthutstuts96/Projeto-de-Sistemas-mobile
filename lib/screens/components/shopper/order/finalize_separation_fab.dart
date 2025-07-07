import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/shopper_controller.dart';
import 'package:projeto_de_sistemas/screens/components/button.dart';
import 'package:provider/provider.dart';

class FinalizeSeparationFAB extends StatelessWidget {
  const FinalizeSeparationFAB({super.key});

  @override
  Widget build(BuildContext context) {
    final shopperController = context.watch<ShopperController>();
    final bool hasActiveTask = shopperController.activeTask != null;

    return FloatingActionButton.extended(
      onPressed:
          !hasActiveTask
              ? null
              : () {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: const Text('Finalizar Separação?'),
                      content: const Text(
                        'Isso irá notificar o entregador que o pedido está pronto para coleta.',
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                          },
                        ),
                        Button(
                          text: 'Confirmar',
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            shopperController.finishSeparationAndNotifyDelivery(
                              context,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Pedido liberado para entrega!"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
      tooltip: 'Finalizar Separação',
      backgroundColor:
          hasActiveTask ? const Color.fromARGB(255, 228, 35, 35) : Colors.grey,
      icon: const Icon(Icons.send_and_archive_outlined, color: Colors.white),
      label: const Text(
        "Liberar para Entrega",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
