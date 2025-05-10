import 'package:flutter/material.dart';

class BottomModal extends StatelessWidget {
  const BottomModal({super.key, required this.onSave});
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.1, // altura inicial (10% da tela)
      minChildSize: 0.1, // altura mínima
      maxChildSize: 0.6, // altura máxima ao expandir
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
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
              const Text("Subtotal: R\$100,00"),
              const Text("Entrega: R\$10,00"),
              const SizedBox(height: 10),
              const Text(
                "Total: R\$110,00",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42),
              ),
              ElevatedButton(
                onPressed: onSave,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green),
                  shadowColor: WidgetStatePropertyAll(Colors.black),
                  elevation: WidgetStatePropertyAll(8),
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
