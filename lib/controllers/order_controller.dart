import 'package:projeto_de_sistemas/domain/models/order/order.dart';
import 'package:projeto_de_sistemas/services/api/order.dart';

class OrderController {
  final OrderApi _orderApi = OrderApi();

  Future<int> saveOrder({required Order order}) async {
    final int success = await _orderApi.saveOrder(order: order);
    print(order);
    return success;
  }
}