import 'package:projeto_de_sistemas/domain/models/products/cart.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';
import 'package:projeto_de_sistemas/domain/repository/cart_repository.dart';
import 'package:projeto_de_sistemas/services/session/cart.dart';

class CartController implements CartRepository {
  final CartSession _cartSession = CartSession();

  @override
  Future<bool> addItemToCart({required Product product}) async {
    await _cartSession.addItemToCart(product);
    return true;
  }

  @override
  Future<Cart?> getCart() async {
    final cart = await _cartSession.getCart();
    return cart;
  }

  @override
  Future<bool> saveCart({required Cart cart}) async {
    await _cartSession.saveCart(cart);
    return true;
  }

  @override
  Future<void> clearCart() async {
    await _cartSession.deleteCart();
  }

  @override
  Future<bool> removeItemFromCart({required Product product}) async {
    return await _cartSession.removeItemFromCart(product);
  }
}
