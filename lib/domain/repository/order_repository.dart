import 'package:projeto_de_sistemas/domain/models/order/order.dart';

abstract class OrderRepository {
    Future<int> saveOrder({required Order order});     
    Future<Order?> getOrderFromSession();
    Future<bool> deleteOrderFromSession();
}