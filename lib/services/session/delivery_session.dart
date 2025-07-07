import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projeto_de_sistemas/domain/models/delivery_task_mock_model.dart';

class DeliveryHistorySession {
  static const String _historyKey =
      'delivery_history'; // Chave para SharedPreferences

  /// Salva uma única DeliveryTaskMock concluída no histórico.
  Future<bool> saveDeliveryToHistory(DeliveryTaskMock task) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Recupera o histórico atual como uma lista de JSONs (Strings)
      List<String> historyJsonList = prefs.getStringList(_historyKey) ?? [];

      // Adiciona a nova tarefa (convertida para JSON String)
      historyJsonList.add(jsonEncode(task.toJson()));

      // Salva a lista atualizada
      await prefs.setStringList(
        _historyKey,
        historyJsonList,
      ); // Correção de _historyListKey para _historyKey
      return true;
    } catch (e) {
      print("DeliveryHistorySession: Erro ao salvar tarefa no histórico: $e");
      return false;
    }
  }

  /// Recupera todas as DeliveryTaskMock do histórico.
  Future<List<DeliveryTaskMock>> getDeliveryHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Recupera a lista de JSONs (Strings)
      List<String> historyJsonList = prefs.getStringList(_historyKey) ?? [];

      // Converte cada JSON String de volta para DeliveryTaskMock
      return historyJsonList.map((jsonString) {
        return DeliveryTaskMock.fromJson(
          jsonDecode(jsonString) as Map<String, dynamic>,
        );
      }).toList();
    } catch (e) {
      print("DeliveryHistorySession: Erro ao recuperar histórico: $e");
      return [];
    }
  }

  /// Limpa todo o histórico de entregas (útil para testes).
  Future<bool> clearDeliveryHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_historyKey);
      print("DeliveryHistorySession: Histórico de entregas limpo.");
      return true;
    } catch (e) {
      print("DeliveryHistorySession: Erro ao limpar histórico: $e");
      return false;
    }
  }
}
