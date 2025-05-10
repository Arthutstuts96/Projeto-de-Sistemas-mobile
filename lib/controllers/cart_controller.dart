import 'package:projeto_de_sistemas/domain/models/products/cart.dart';
import 'package:projeto_de_sistemas/domain/repository/cart_repository.dart';
import 'package:projeto_de_sistemas/services/api/cart.dart';

class CartController implements CartRepository {
  final CartApi _cartApi = CartApi();

  @override
  Future<bool> saveCart({required Cart cart}) async {
    await Future.delayed(Duration(seconds: 2)); 
    return await _cartApi.saveOrder(cart: cart);
  }
}
