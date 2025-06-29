import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/utils/functions/format_functions.dart';

class BottomModal extends StatelessWidget {
  const BottomModal({super.key, required this.onPressed, required this.fullPrice});
  final VoidCallback onPressed;
  final double fullPrice;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.1, // altura inicial (10% da tela)
      minChildSize: 0.1, // altura mínima
      maxChildSize: 0.6, // altura máxima ao expandir
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            children: [
              const Center(child: Icon(Icons.drag_handle, color: Colors.grey)),
              const Text(
                "Resumo do Pedido",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text("Subtotal: R\$${fullPrice.toStringAsFixed(2).replaceAll(".", ",")}"),
              const Text("Entrega: R\$0,00"),
              const SizedBox(height: 10),
              Text(
                "Total: R\$${(formatMonetary(fullPrice))}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 42),
              ),
              ElevatedButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  backgroundColor: const WidgetStatePropertyAll(Colors.green),
                  shadowColor: const WidgetStatePropertyAll(Colors.black),
                  elevation: const WidgetStatePropertyAll(8),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                child: const Text(
                  "Finalizar pedido",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
