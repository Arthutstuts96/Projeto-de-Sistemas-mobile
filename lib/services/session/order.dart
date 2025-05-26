import 'dart:convert';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderSession {
  static const String _orderKey = 'order';

  // Salva uma order na sessão
  Future<bool> saveOrder(Order order) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_orderKey, jsonEncode(order.toJson()));
      return true;
    } catch (e) {
      return false;
    }
  }

  // Recupera a order da sessão
  Future<Order?> getOrder() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? orderJson = prefs.getString(_orderKey);
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
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_orderKey);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Atualiza a order na sessão
  Future<bool> updateOrder(Order updatedOrder) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final existingOrderJson = prefs.getString(_orderKey);
      if (existingOrderJson == null) {
        // Não existe order para atualizar
        return false;
      }

      await prefs.setString(_orderKey, jsonEncode(updatedOrder.toJson()));
      return true;
    } catch (e) {
      return false;
    }
  }
}
