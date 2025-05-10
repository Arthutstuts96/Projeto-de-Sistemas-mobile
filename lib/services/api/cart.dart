import 'package:dio/dio.dart';
import 'package:projeto_de_sistemas/domain/models/products/cart.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';
import 'package:projeto_de_sistemas/utils/api_configs.dart';

class CartApi {
  final Dio dio = Dio();

  Future<bool> saveOrder({required Cart cart}) async{
    //TODO: requisição para enviar o carrinho e pedido
    return true;
  }
}
