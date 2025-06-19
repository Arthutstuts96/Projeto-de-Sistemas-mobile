import 'dart:convert';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';
import 'package:projeto_de_sistemas/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderSession {
  static const String _orderKey = 'order';
  final SharedPreferences _prefs;

  OrderSession() : _prefs = getIt<SharedPreferences>();
  OrderSession.testable({required SharedPreferences prefs}) : _prefs = prefs;

  // Salva uma order na sessão
  Future<bool> saveOrder(Order order) async {
    try {
      await _prefs.setString(_orderKey, jsonEncode(order.toJson()));
      return true;
    } catch (e) {
      return false;
    }
  }

  // Recupera a order da sessão
  Future<Order?> getOrder() async {
    try {
      final String? orderJson = _prefs.getString(_orderKey);
      if (orderJson != null) {
        return Order.fromJson(jsonDecode(orderJson));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Remove a order da sessão
  Future<bool> deleteOrder() async {
    try {
      await _prefs.remove(_orderKey);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Atualiza a order na sessão
  Future<bool> updateOrder(Order updatedOrder) async {
    try {
      final existingOrderJson = _prefs.getString(_orderKey);
      if (existingOrderJson == null) {
        // Não existe order para atualizar
        return false;
      }

      await _prefs.setString(_orderKey, jsonEncode(updatedOrder.toJson()));
      return true;
    } catch (e) {
      return false;
    }
  }
}
