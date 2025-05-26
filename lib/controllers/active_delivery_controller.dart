// lib/controllers/active_delivery_controller.dart
import 'package:flutter/foundation.dart';
import '../domain/models/delivery_task_mock_model.dart';
// Remova o import de 'delivery_task_mocks.dart' se 'obterNovoDeliveryTaskMock' não for mais usado aqui

class ActiveDeliveryController with ChangeNotifier {
  DeliveryTaskMock? _currentTask;
  bool _popupForCurrentTaskShown = false;
  final String _simulatedDriverId = "driver_beta_01";

  DeliveryTaskMock? get currentTask => _currentTask;

  bool get shouldShowNewTaskPopup =>
      _currentTask != null &&
      _currentTask!.status ==
          DeliveryTaskStatusMock.aguardandoAceiteEntregador &&
      !_popupForCurrentTaskShown;

  // MÉTODO MODIFICADO para aceitar dados do pedido
  void simulateNewTaskAvailable({
    required String orderId, // ID do pedido original do cliente
    required String
    customerName, // Nome do cliente (pode ser mockado se não tiver)
    required String deliveryAddress, // Endereço de entrega
    required String itemsSummary, // Um resumo dos itens
  }) {
    if (_currentTask == null ||
        _currentTask!.status == DeliveryTaskStatusMock.entregue) {
      _currentTask = DeliveryTaskMock(
        id: "TASK_FROM_${orderId}_${DateTime.now().millisecondsSinceEpoch}", // Cria um ID de tarefa baseado no pedido
        nomeCliente: customerName,
        enderecoEntrega: deliveryAddress,
        itensResumo: itemsSummary,
        status: DeliveryTaskStatusMock.aguardandoAceiteEntregador,
      );
      _popupForCurrentTaskShown = false;
      print(
        "NOVA TAREFA DE ENTREGA (DO PEDIDO REAL $orderId): ${_currentTask!.id}",
      );
      notifyListeners();
    } else {
      print(
        "Ainda há uma tarefa ativa (${_currentTask!.id}), nova tarefa (do pedido $orderId) não gerada.",
      );
    }
  }

  // ... resto dos métodos (acceptTask, declineTask, etc. permanecem os mesmos) ...
  void acceptTask() {
    if (_currentTask != null) {
      _currentTask!.status = DeliveryTaskStatusMock.aceitoPeloEntregador;
      _currentTask!.idEntregadorAtribuido = _simulatedDriverId;
      print(
        "TAREFA ACEITA: ${_currentTask!.id} pelo entregador $_simulatedDriverId",
      );
      _popupForCurrentTaskShown = true;
      notifyListeners();
    }
  }

  void declineTask() {
    if (_currentTask != null) {
      print("TAREFA RECUSADA: ${_currentTask!.id}");
      _clearCurrentTask();
    }
  }

  void confirmCollection() {
    if (_currentTask != null &&
        _currentTask!.status == DeliveryTaskStatusMock.aceitoPeloEntregador) {
      _currentTask!.status = DeliveryTaskStatusMock.coletadoPeloEntregador;
      print("TAREFA COLETADA: ${_currentTask!.id}");
      notifyListeners();
    }
  }

  void confirmDelivery() {
    if (_currentTask != null &&
        _currentTask!.status == DeliveryTaskStatusMock.coletadoPeloEntregador) {
      _currentTask!.status = DeliveryTaskStatusMock.entregue;
      print("TAREFA ENTREGUE: ${_currentTask!.id}");
      notifyListeners();
    }
  }

  void markPopupAsShown() {
    _popupForCurrentTaskShown = true;
  }

  void clearCurrentTask() {
    _clearCurrentTask();
  }

  void _clearCurrentTask() {
    _currentTask = null;
    _popupForCurrentTaskShown = false;
    notifyListeners();
  }
}
