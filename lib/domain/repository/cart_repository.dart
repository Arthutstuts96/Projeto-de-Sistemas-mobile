import 'package:projeto_de_sistemas/domain/models/products/cart.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';

abstract class CartRepository {
    Future<void> saveCart({required Cart cart});     
    Future<void> addItemToCart({required Product product});
    Future<void> removeItemFromCart({required Product product});
    Future<Cart?> getCart();
    Future<void> clearCart();
}