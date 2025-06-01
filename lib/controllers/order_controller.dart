import 'package:projeto_de_sistemas/domain/models/order/order.dart';
import 'package:projeto_de_sistemas/domain/repository/order_repository.dart';
import 'package:projeto_de_sistemas/services/api/order_api.dart';
import 'package:projeto_de_sistemas/services/session/order_session.dart';

class OrderController extends OrderRepository {
  final OrderApi _orderApi = OrderApi();
  final OrderSession _orderSession = OrderSession();

  @override
  Future<Order?> getOrderFromSession() async{
    return await _orderSession.getOrder();
  }

  @override
  Future<int> saveOrder({required Order order}) async{
    final int success = await _orderApi.saveOrder(order: order);
    return success;
  }
  
  @override
  Future<bool> deleteOrderFromSession() async{
    return await _orderSession.deleteOrder();
  }
}