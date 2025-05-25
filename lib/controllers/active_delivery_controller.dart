// lib/controllers/active_delivery_controller.dart
import 'package:flutter/foundation.dart';
import '../domain/models/delivery_task_mock.dart';
import '../data/mocks/delivery_task_mocks.dart';

class ActiveDeliveryController with ChangeNotifier {
  DeliveryTaskMock? _currentTask;
  bool _popupForCurrentTaskShown = false;
  final String _simulatedDriverId =
      "driver_beta_01";

  DeliveryTaskMock? get currentTask => _currentTask;

  bool get shouldShowNewTaskPopup =>
      _currentTask != null &&
      _currentTask!.status ==
          DeliveryTaskStatusMock.aguardandoAceiteEntregador &&
      !_popupForCurrentTaskShown;

  // CHAMADO QUANDO O CLIENTE "FINALIZA O PEDIDO"
  void simulateNewTaskAvailable() {
    // Só pega uma nova tarefa se não houver uma ativa ou se a anterior foi concluída
    if (_currentTask == null ||
        _currentTask!.status == DeliveryTaskStatusMock.entregue) {
      _currentTask = obterNovoDeliveryTaskMock();
      if (_currentTask != null) {
        _currentTask!.status =
            DeliveryTaskStatusMock.aguardandoAceiteEntregador;
        _popupForCurrentTaskShown = false; // Reset para a nova tarefa
        print("NOVA TAREFA DE ENTREGA SIMULADA: ${_currentTask!.id}");
        notifyListeners();
      }
    } else {
      print(
        "Ainda há uma tarefa ativa (${_currentTask!.id}), nova tarefa não gerada.",
      );
    }
  }

  void acceptTask() {
    if (_currentTask != null) {
      _currentTask!.status = DeliveryTaskStatusMock.aceitoPeloEntregador;
      _currentTask!.idEntregadorAtribuido = _simulatedDriverId;
      // TODO: Quando integrar, chamar API: POST /api/pedidos/{id}/aceitar-coleta-beta/
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
      // TODO: Quando integrar, chamar API: POST /api/pedidos/{id}/recusar-coleta-beta/
      _clearCurrentTask(); // Limpa a tarefa, entregador não quer
    }
  }

  void confirmCollection() {
    if (_currentTask != null &&
        _currentTask!.status == DeliveryTaskStatusMock.aceitoPeloEntregador) {
      _currentTask!.status = DeliveryTaskStatusMock.coletadoPeloEntregador;
      // TODO: Quando integrar, chamar API (ex: PATCH /api/pedidos/{id}/status body: {status: "coletado"})
      print("TAREFA COLETADA: ${_currentTask!.id}");
      notifyListeners();
    }
  }

  void confirmDelivery() {
    if (_currentTask != null &&
        _currentTask!.status == DeliveryTaskStatusMock.coletadoPeloEntregador) {
      _currentTask!.status = DeliveryTaskStatusMock.entregue;
      // TODO: Quando integrar, chamar API: POST /api/pedidos/{id}/finalizar-entrega-beta/
      print("TAREFA ENTREGUE: ${_currentTask!.id}");
      notifyListeners();
      // Poderia limpar a tarefa aqui após um tempo ou deixar para o usuário limpar manualmente
      // _clearCurrentTaskAfterDelay();
    }
  }

  void markPopupAsShown() {
    _popupForCurrentTaskShown = true;
    // Não é essencial notificar listeners aqui, a menos que a UI dependa diretamente desta flag
    // para algo além do controle de exibição do popup (que é feito via shouldShowNewTaskPopup)
  }

  // Para o usuário/teste poder resetar o estado e simular novamente
  void clearCurrentTask() {
    _clearCurrentTask();
  }

  void _clearCurrentTask() {
    _currentTask = null;
    _popupForCurrentTaskShown = false;
    notifyListeners();
  }
}
