import 'dart:convert';
import 'package:projeto_de_sistemas/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projeto_de_sistemas/domain/models/delivery_task_mock_model.dart';

class DeliveryHistorySession {
  static const String _historyKey = 'delivery_history';
  final SharedPreferences _prefs;

  DeliveryHistorySession() : _prefs = getIt<SharedPreferences>();
  DeliveryHistorySession.testable({required SharedPreferences prefs})
    : _prefs = prefs;

  Future<bool> saveDeliveryToHistory(DeliveryTaskMock task) async {
    try {
      List<String> historyJsonList = _prefs.getStringList(_historyKey) ?? [];
      historyJsonList.add(jsonEncode(task.toJson()));

      await _prefs.setStringList(_historyKey, historyJsonList);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<DeliveryTaskMock>> getDeliveryHistory() async {
    try {
      List<String> historyJsonList = _prefs.getStringList(_historyKey) ?? [];

      return historyJsonList.map((jsonString) {
        return DeliveryTaskMock.fromJson(
          jsonDecode(jsonString) as Map<String, dynamic>,
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  /// Limpa todo o histórico de entregas (útil para testes).
  Future<bool> clearDeliveryHistory() async {
    try {
      await _prefs.remove(_historyKey);
      return true;
    } catch (e) {
      return false;
    }
  }
}
