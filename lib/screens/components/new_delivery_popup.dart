// lib/screens/components/new_delivery_popup.dart
import 'package:flutter/material.dart';
import '../../domain/models/delivery_task_mock_model.dart'; // Ajuste o caminho

Future<void> showNewDeliveryPopup({
  required BuildContext context,
  required DeliveryTaskMock task,
  required VoidCallback onAccept,
  required VoidCallback onDecline,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('Nova Tarefa de Entrega!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Tarefa #${task.id.split('_').first}'), // Mostra ID base
              Text('Cliente: ${task.nomeCliente}'),
              Text('Itens: ${task.itensResumo}'),
              SizedBox(height: 10),
              Text('Deseja aceitar esta entrega?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('NÃO, RECUSAR'),
            onPressed: () {
              Navigator.of(
                dialogContext,
              ).pop(); // Fecha o dialog ANTES de chamar o callback
              onDecline();
            },
          ),
          ElevatedButton(
            child: Text('SIM, ACEITAR'),
            onPressed: () {
              Navigator.of(
                dialogContext,
              ).pop(); // Fecha o dialog ANTES de chamar o callback
              onAccept();
            },
          ),
        ],
      );
    },
  );
}
