// lib/controllers/delivery_history_controller.dart
import 'package:flutter/foundation.dart'; // Para ChangeNotifier
import 'package:projeto_de_sistemas/domain/models/delivery_task_mock_model.dart'; // Ajuste o caminho
import 'package:projeto_de_sistemas/services/session/delivery_session.dart'; // Ajuste o caminho

class DeliveryHistoryController with ChangeNotifier {
  final DeliveryHistorySession _historySession = DeliveryHistorySession();
  List<DeliveryTaskMock> _deliveryHistory = []; // Lista interna do histórico

  List<DeliveryTaskMock> get deliveryHistory =>
      _deliveryHistory; // Getter para expor o histórico

  // Construtor: Carrega o histórico ao criar o controlador
  DeliveryHistoryController() {
    _loadDeliveryHistory();
  }

  /// Carrega o histórico de entregas do SharedPreferences.
  Future<void> _loadDeliveryHistory() async {
    _deliveryHistory = await _historySession.getDeliveryHistory();
    notifyListeners(); // Notifica os ouvintes que o histórico foi carregado/atualizado
  }

  /// Adiciona uma tarefa ao histórico e a recarrega (se você quiser adicionar por aqui tbm).
  /// Normalmente, a adição virá do ActiveDeliveryController.
  Future<void> addDeliveryToHistory(DeliveryTaskMock task) async {
    await _historySession.saveDeliveryToHistory(task);
    await _loadDeliveryHistory(); // Recarrega para obter a lista atualizada
  }

  /// Recarrega o histórico.
  Future<void> refreshHistory() async {
    await _loadDeliveryHistory();
  }

  /// Limpa todo o histórico (para testes).
  Future<void> clearHistory() async {
    await _historySession.clearDeliveryHistory();
    await _loadDeliveryHistory(); // Recarrega para mostrar uma lista vazia
  }
}
