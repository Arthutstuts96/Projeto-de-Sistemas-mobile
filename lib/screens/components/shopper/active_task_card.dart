import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_de_sistemas/controllers/shopper_controller.dart';
import 'package:projeto_de_sistemas/screens/shopper/shopper_order_screen.dart'; 

class ActiveTaskCard extends StatelessWidget {
  final SeparationTask task;

  const ActiveTaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final int totalUnits = task.items.fold(0, (sum, item) => sum + item.quantidade);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.assignment_turned_in_outlined, color: Colors.green, size: 28),
                    SizedBox(width: 12),
                    Text(
                      "Pedido em andamento",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(height: 24),

                // --- Detalhes do Pedido ---
                _buildInfoRow(
                  icon: Icons.store_mall_directory_outlined,
                  label: "Supermercado:",
                  value: "Supermercado Brasil",
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  icon: Icons.person_outline,
                  label: "Cliente:",
                  value: task.customerName,
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  icon: Icons.shopping_basket_outlined,
                  label: "Total de itens:",
                  value: "$totalUnits unidades",
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  icon: Icons.access_time,
                  label: "Aceito em:",
                  value: DateFormat('dd/MM/yy HH:mm').format(task.criadoEm.toLocal()),
                ),
                const SizedBox(height: 24),
                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ShopperOrderScreen()),
                      );
                    },
                    icon: const Icon(Icons.checklist_rtl_outlined),
                    label: const Text("VER LISTA DE ITENS"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 228, 35, 35),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.black54, size: 20),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}