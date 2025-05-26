import 'package:dio/dio.dart';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';
import 'package:projeto_de_sistemas/services/session/order.dart';
import 'package:projeto_de_sistemas/utils/api_configs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderApi {
  final Dio dio = Dio();

  Future<int> saveOrder({required Order order}) async {
    final OrderSession orderSession = OrderSession();

    try {
      //Deleta pedido atual
      await orderSession.deleteOrder();

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        throw Exception('Token não encontrado. Usuário não autenticado.');
      }
      print(order);
      final response = await dio.post(
        '$ipHost/pedidos/create',
        data: {
          "numero_pedido": order.numeroPedido,
          "usuario": order.usuario,
          "status_pagamento": order.statusPagamento,
          "status_pedido": order.statusPedido,
          "valor_total": double.parse(order.valorTotal.toStringAsFixed(2)),
          "descricao": order.descricao,
          "data_pagamento": order.dataPagamento?.toIso8601String(),
          "criado_em": order.criadoEm.toIso8601String(),
          "dados_entrega":
              order.dadosEntrega
                  ?.map(
                    (d) => {
                      "tipo_veiculo": d.tipoVeiculo,
                      "endereco_id": d.enderecoId,
                    },
                  )
                  .toList(),
          "itens":
              order.itens
                  .map(
                    (item) => {
                      "produto_id": item.produtoId,
                      "quantidade": item.quantidade,
                      "preco_unitario": item.precoUnitario,
                      "disponibilidade": item.disponibilidade,
                    },
                  )
                  .toList(),
        },
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await orderSession.saveOrder(order);
      }

      return response.statusCode ?? 0;
    } catch (e) {
      return 0;
    }
  }
}
