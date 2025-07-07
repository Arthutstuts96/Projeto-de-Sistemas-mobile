import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/active_delivery_controller.dart';
import 'package:projeto_de_sistemas/domain/models/delivery_task_mock_model.dart';
import 'package:projeto_de_sistemas/screens/components/delivery/delivery_action_button.dart';
import 'package:projeto_de_sistemas/screens/components/delivery/delivery_info_card.dart';
import 'package:projeto_de_sistemas/screens/components/delivery/task_detail_row.dart';
import 'package:projeto_de_sistemas/utils/functions/delivery_status_utils.dart';

class DeliveryTaskSheetContent extends StatelessWidget {
  final DeliveryTaskMock? task;
  final ActiveDeliveryController deliveryController;

  const DeliveryTaskSheetContent({
    super.key,
    required this.task,
    required this.deliveryController,
  });

  @override
  Widget build(BuildContext context) {
    if (task != null && task!.status != DeliveryTaskStatusMock.entregue) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 0, bottom: 10),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
            Text(
              'Tarefa: ${task!.itensResumo}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TaskDetailRow(
              label: 'ID Simulado:',
              value: task!.id.split('_').last,
            ),
            TaskDetailRow(label: 'Cliente:', value: task!.nomeCliente),
            TaskDetailRow(label: 'Endereço:', value: task!.enderecoEntrega),
            const SizedBox(height: 16),
            const Text(
              'Status Atual:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              getStatusText(task!.status),
              style: TextStyle(
                fontSize: 18,
                color: getStatusColor(task!.status),
              ),
            ),
            const SizedBox(height: 24),

            if (task!.status == DeliveryTaskStatusMock.aceitoPeloEntregador ||
                task!.status ==
                    DeliveryTaskStatusMock.aguardandoAceiteEntregador)
              BuildActionButton(
                label: 'IR PARA O MERCADO',
                onPressed: () {
                  deliveryController.startNavigationToMercado(context);
                },
                color: Colors.blueAccent,
              ),
            const SizedBox(height: 16),

            if (task!.status == DeliveryTaskStatusMock.aceitoPeloEntregador)
              BuildActionButton(
                label: 'CONFIRMAR COLETA',
                onPressed: () => deliveryController.confirmCollection(),
                color: Colors.orange,
              ),
            const SizedBox(height: 16),

            if (task!.status == DeliveryTaskStatusMock.coletadoPeloEntregador)
              BuildActionButton(
                label: 'NAVEGAR PARA O CLIENTE',
                onPressed: () {
                  deliveryController.startNavigationToClient(context);
                },
                color: Colors.purple,
              ),
            const SizedBox(height: 16),

            if (task!.status == DeliveryTaskStatusMock.coletadoPeloEntregador)
              BuildActionButton(
                label: 'CONFIRMAR ENTREGA',
                onPressed: () => deliveryController.confirmDelivery(),
                color: Colors.green,
              ),
            const SizedBox(height: 20),
          ],
        ),
      );
    } else if (task != null &&
        task!.status == DeliveryTaskStatusMock.entregue) {
      return Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Entrega "${task!.itensResumo}" Concluída!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      deliveryController.clearCurrentTask();
                    },
                    child: const Text("OK / Ver Novas Tarefas"),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Novidades',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [Image.asset("assets/images/delivery.png")],
            ),
          ),
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: DeliveryInfoCard(
                    title: 'Seus ganhos',
                    details: [
                      'Ganhos do dia',
                      'R\$ 100,00',
                      'Saldo total: R\$ 1000,00',
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DeliveryInfoCard(
                    title: 'Rotas',
                    details: [
                      'Rotas aceitas: 15',
                      'Finalizadas: 12',
                      'Recusadas: 3',
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      );
    }
  }
}
