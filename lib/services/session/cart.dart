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
            client: 0, // Valor padrão, ajuste conforme necessário
            paymentStatus: 'PENDING',
            orderStatus: 'OPEN',
            totalValue: 0.0,
          );

      // Adiciona o novo produto
      cart.cartItems.add(product);
      // Atualiza o valor total
      cart.totalValue += product.unityPrice * product.quantity;

      // Salva o carrinho atualizado
      await prefs.setString(_cartKey, jsonEncode(cart.toJson()));

      // Imprime o conteúdo do armazenamento da sessão
      final String? cartJson = prefs.getString(_cartKey);
      print('Armazenamento da sessão: $cartJson');

      return true;
    } catch (e) {
      print('Erro ao adicionar item ao carrinho: $e');
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
        print('Erro: Carrinho vazio.');
        return false;
      }

      // Encontra e remove o produto com base no barCode
      final initialLength = cart.cartItems.length;
      cart.cartItems.removeWhere((item) => item.barCode == product.barCode);
      if (cart.cartItems.length == initialLength) {
        print('Erro: Produto não encontrado no carrinho.');
        return false;
      }

      // Atualiza o valor total
      cart.totalValue -= product.unityPrice * product.quantity;

      // Salva o carrinho atualizado
      await prefs.setString(_cartKey, jsonEncode(cart.toJson()));

      // Imprime o conteúdo do armazenamento da sessão
      final String? cartJson = prefs.getString(_cartKey);
      print('Armazenamento da sessão após remoção: $cartJson');

      return true;
    } catch (e) {
      print('Erro ao remover item do carrinho: $e');
      return false;
    }
  }
}
