import 'dart:convert';
import 'package:projeto_de_sistemas/domain/models/products/cart.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartSession {
  static const String _cartKey = 'cart';

  // Adiciona um item ao carrinho
  Future<bool> addItemToCart(Product product) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Recupera o carrinho atual ou cria um novo
      Cart cart =
          await getCart() ??
          Cart(
            cartItems: [],
            orderNumber: 'ORDER_${DateTime.now().millisecondsSinceEpoch}',
            itensPrice: 0.0,
            client: 0, // Valor padrão, ajuste conforme necessário
          );

      // Verifica se o produto já está no carrinho
      final existingProductIndex = cart.cartItems.indexWhere(
        (item) => item.id == product.id,
      );

      if (existingProductIndex != -1) {
        cart.cartItems[existingProductIndex].quantityToBuy += 1;
      } else {
        cart.cartItems.add(product);
      }

      cart.itensPrice = cart.cartItems.fold(
        0.0,
        (total, item) => total + (item.unityPrice * item.quantityToBuy),
      );

      // Salva o carrinho atualizado
      await prefs.setString(_cartKey, jsonEncode(cart.toJson()));
      return true;
    } catch (e) {
      return false;
    }
  }

  // Recupera o carrinho do armazenamento
  Future<Cart?> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartJson = prefs.getString(_cartKey);
    if (cartJson != null) {
      return Cart.fromJson(jsonDecode(cartJson));
    }
    return null;
  }

  // Salva o carrinho inteiro
  Future<void> saveCart(Cart cart) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cartKey, jsonEncode(cart.toJson()));
  }

  // Função para limpar o carrinho do armazenamento da sessão
  Future<void> deleteCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }

  // Remove um item do carrinho pelo produto e retorna true se bem-sucedido, false caso contrário
  Future<bool> removeItemFromCart(Product product) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Recupera o carrinho atual
      Cart? cart = await getCart();
      if (cart == null || cart.cartItems.isEmpty) {
        return false;
      }

      // Encontra e remove o produto com base no barCode
      final initialLength = cart.cartItems.length;
      cart.cartItems.removeWhere((item) => item.barCode == product.barCode);
      if (cart.cartItems.length == initialLength) {
        return false;
      }

      // Atualiza o valor total
      cart.itensPrice -= product.unityPrice * product.quantityToBuy;

      // Salva o carrinho atualizado
      await prefs.setString(_cartKey, jsonEncode(cart.toJson()));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> editItemInCart(Product updatedProduct) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      Cart? cart = await getCart();

      if (cart == null || cart.cartItems.isEmpty) {
        return false;
      }

      bool found = false;

      for (int i = 0; i < cart.cartItems.length; i++) {
        final item = cart.cartItems[i];
        if (item.id == updatedProduct.id) {
          cart.itensPrice -= item.unityPrice * item.quantityToBuy;
          cart.itensPrice +=
              updatedProduct.unityPrice * updatedProduct.quantityToBuy;

          cart.cartItems[i] = updatedProduct;
          found = true;
          break;
        }
      }
      // Não achou
      if (!found) return false;

      await prefs.setString(_cartKey, jsonEncode(cart.toJson()));
      return true;
    } catch (e) {
      return false;
    }
  }
}
