import 'package:dio/dio.dart';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';
import 'package:projeto_de_sistemas/locator.dart';
import 'package:projeto_de_sistemas/services/session/order_session.dart';
import 'package:projeto_de_sistemas/utils/api_configs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderApi {
  final Dio _dio;
  final SharedPreferences _prefs;
  final OrderSession _orderSession;

  OrderApi()
    : _dio = getIt<Dio>(),
      _prefs = getIt<SharedPreferences>(),
      _orderSession = getIt<OrderSession>();
  OrderApi.testable({
    required Dio dio,
    required SharedPreferences prefs,
    required OrderSession orderSession,
  }) : _dio = dio,
       _prefs = prefs,
       _orderSession = orderSession;

  Future<int> saveOrder({required Order order}) async {
    try {
      //Deleta pedido atual
      await _orderSession.deleteOrder();

      final token = _prefs.getString('access_token');

      if (token == null) {
        throw Exception('Token não encontrado. Usuário não autenticado.');
      }

      var data = {
        "numero_pedido": order.numeroPedido,
        "usuario": order.usuario,
        "status_pagamento": order.statusPagamento,
        "status_pedido": order.statusPedido,
        "valor_total": order.valorTotal.toStringAsFixed(2),
        "descricao": order.descricao,
        "data_pagamento": order.dataPagamento?.toIso8601String(),
        "dados_entrega": [
          {
            "tipo_veiculo": order.dadosEntrega?.tipoVeiculo,
            "endereco_id": order.dadosEntrega?.enderecoId,
          },
        ],
        "itens":
            order.itens
                .map(
                  (item) => {
                    "produto_id": item.produtoId,
                    "quantidade": item.quantidade,
                    "preco_unitario": item.precoUnitario.toStringAsFixed(2),
                    "disponibilidade": item.disponibilidade,
                  },
                )
                .toList(),
      };
      print(data);

      Response response = await _dio.post(
        '$ipHost/pedidos/create',
        data: data,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await _orderSession.saveOrder(order);
      }

      return response.statusCode ?? 0;
    } on DioException catch (e) {
      // print('  Status Code: ${e.response?.statusCode}');
      print('  Corpo da Resposta do Servidor: ${e.response?.data}');
      return 0;
    } catch (e) {
      return 0;
    }
  }
}
