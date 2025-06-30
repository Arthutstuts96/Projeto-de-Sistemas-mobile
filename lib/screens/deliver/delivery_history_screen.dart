import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_de_sistemas/controllers/delivery_history_controller.dart'; 
import 'package:projeto_de_sistemas/domain/models/delivery_task_mock_model.dart';
import 'package:universal_stepper/universal_stepper.dart';
import 'package:projeto_de_sistemas/utils/functions/delivery_status_utils.dart';

class DeliveryHistoryScreen extends StatelessWidget {
  const DeliveryHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Usa Consumer para observar as mudanças em DeliveryHistoryController
    return Consumer<DeliveryHistoryController>(
      builder: (context, controller, child) {
        final List<DeliveryTaskMock> history = controller.deliveryHistory;

        if (history.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Nenhuma entrega concluída ainda.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.refreshHistory(); // Tentar recarregar
                  },
                  child: const Text('Recarregar Histórico'),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.clearHistory(); // Botão para limpar para testes
                  },
                  child: const Text('Limpar Histórico (Testes)'),
                ),
              ],
            ),
          );
        }

        // Adaptação da estrutura do seu OrderHistory
        return RefreshIndicator(
          // Adiciona funcionalidade de pull-to-refresh
          onRefresh: () => controller.refreshHistory(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            physics:
                const AlwaysScrollableScrollPhysics(), // Garante que o Pull-to-Refresh funcione mesmo com pouco conteúdo
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Histórico de Entregas",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                // Usar ListView.builder para uma lista simples
                ListView.builder(
                  shrinkWrap:
                      true, // Importante para ListView dentro de SingleChildScrollView/Column
                  physics:
                      const NeverScrollableScrollPhysics(), // Evita scroll aninhado
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final task = history[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 4,
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pedido: ${task.id.split('_').last}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text('Cliente: ${task.nomeCliente}'),
                            Text('Endereço: ${task.enderecoEntrega}'),
                            Text('Resumo: ${task.itensResumo}'),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  'Status: ${getStatusText(task.status)}',
                                  style: TextStyle(
                                    color: getStatusColor(task.status),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(), // Empurra a data para a direita
                                Text(
                                  'Data: ${task.criadoEm.day}/${task.criadoEm.month}/${task.criadoEm.year}',
                                ), // Adicione data real se seu mock tiver
                              ],
                            ),
                            // Adicione mais detalhes conforme necessário
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // Se você quiser usar o UniversalStepper, adapte este bloco:
                // UniversalStepper(
                //   // ... a lógica do UniversalStepper, mas usando 'history.length'
                //   // e os dados de 'history[index]' para os cards
                //   elementCount: history.length,
                //   elementBuilder: (context, index) {
                //     final task = history[index];
                //     return Expanded(
                //       child: Container(
                //         padding: const EdgeInsets.only(left: 12, bottom: 16),
                //         child: Card(
                //           // Conteúdo do seu card adaptado para DeliveryTaskMock
                //           child: Text(task.nomeCliente),
                //         ),
                //       ),
                //     );
                //   },
                //   // ... outros builders
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
