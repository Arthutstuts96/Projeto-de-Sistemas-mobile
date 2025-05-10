import 'package:projeto_de_sistemas/domain/models/products/cart.dart';

abstract class CartRepository {
    Future<void> saveCart({required Cart cart});     
}