import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/active_delivery_controller.dart';
import 'package:projeto_de_sistemas/domain/models/order/order_item.dart';
import 'package:provider/provider.dart';

class SeparationTask {
  final String orderId;
  final String customerName;
  final String deliveryAddress;
  final List<OrderItem> items;
  final String? description;
  final double mercadoLatitude;
  final double mercadoLongitude;
  final double clientLatitude;
  final double clientLongitude;
  final DateTime criadoEm;

  SeparationTask({
    required this.orderId,
    required this.customerName,
    required this.deliveryAddress,
    required this.items,
    this.description,
    required this.mercadoLatitude,
    required this.mercadoLongitude,
    required this.clientLatitude,
    required this.clientLongitude,
    required this.criadoEm,
  });
}

class ShopperController with ChangeNotifier {
  final List<SeparationTask> _tasks = [];
  SeparationTask? _activeTask;

  List<SeparationTask> get tasks => _tasks;
  SeparationTask? get activeTask => _activeTask;

  void clearActiveTask() {
    _activeTask = null;
    notifyListeners();
  }

  void addNewSeparationTask({
    required String orderId,
    required String customerName,
    required String deliveryAddress,
    required List<OrderItem> items,
    String? description,
    required double mercadoLatitude,
    required double mercadoLongitude,
    required double clientLatitude,
    required double clientLongitude,
    required DateTime criadoEm,
  }) {
    final newTask = SeparationTask(
      orderId: orderId,
      customerName: customerName,
      deliveryAddress: deliveryAddress,
      items: items,
      description: description,
      mercadoLatitude: mercadoLatitude,
      mercadoLongitude: mercadoLongitude,
      clientLatitude: clientLatitude,
      clientLongitude: clientLongitude,
      criadoEm: criadoEm,
    );

    _tasks.add(newTask);
    notifyListeners();
  }

  void acceptTask(SeparationTask task) {
    if (_activeTask != null) {
      return;
    }
    _activeTask = task;
    _tasks.removeWhere((t) => t.orderId == task.orderId);

    notifyListeners();
  }

  void finishSeparationAndNotifyDelivery(BuildContext context) {
    if (_activeTask == null) {
      return;
    }
    final taskToComplete = _activeTask!;

    String itemsSummary = taskToComplete.items
        .map((item) => "${item.quantidade}x Produto")
        .join(', ');

    Provider.of<ActiveDeliveryController>(
      context,
      listen: false,
    ).simulateNewTaskAvailable(
      orderId: taskToComplete.orderId,
      customerName: taskToComplete.customerName,
      deliveryAddress: taskToComplete.deliveryAddress,
      itemsSummary: itemsSummary,
      mercadoLatitude: taskToComplete.mercadoLatitude,
      mercadoLongitude: taskToComplete.mercadoLongitude,
      clientLatitude: taskToComplete.clientLatitude,
      clientLongitude: taskToComplete.clientLongitude,
      criadoEm: taskToComplete.criadoEm,
    );

    // Limpa a tarefa ativa
    clearActiveTask();
  }
}
