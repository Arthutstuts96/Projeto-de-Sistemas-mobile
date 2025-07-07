import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/domain/models/delivery_task_mock_model.dart'; // Ajuste o caminho

String getStatusText(DeliveryTaskStatusMock status) {
  switch (status) {
    case DeliveryTaskStatusMock.aguardandoAceiteEntregador:
      return 'Aguardando Aceite';
    case DeliveryTaskStatusMock.aceitoPeloEntregador:
      return 'Aceita - Pronta para Coleta';
    case DeliveryTaskStatusMock.coletadoPeloEntregador:
      return 'Coletada - Em Rota de Entrega';
    case DeliveryTaskStatusMock.entregue:
      return 'Entregue';
  }
}

Color getStatusColor(DeliveryTaskStatusMock status) {
  switch (status) {
    case DeliveryTaskStatusMock.aceitoPeloEntregador:
      return Colors.blueAccent;
    case DeliveryTaskStatusMock.coletadoPeloEntregador:
      return Colors.orangeAccent;
    case DeliveryTaskStatusMock.entregue:
      return Colors.green;
    default:
      return Colors.grey;
  }
}
