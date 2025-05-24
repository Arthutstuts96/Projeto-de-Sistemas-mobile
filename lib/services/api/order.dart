import 'package:dio/dio.dart';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';
import 'package:projeto_de_sistemas/utils/api_configs.dart';

class OrderApi {
  final Dio dio = Dio();

  Future<int> saveOrder({required Order order}) async {
    try {
      final response = await dio.post(
        '$ipHost/pedidos/create',
        data: {
          "numero_pedido": order.numeroPedido,
          "usuario": order.usuario,
          "status_pagamento": order.statusPagamento,
          "status_pedido": order.statusPedido,
          "valor_total": order.valorTotal,
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
        options: Options(contentType: Headers.jsonContentType),
      );

      return response.statusCode ?? 0;
    } catch (e) {
      print("Erro ao salvar usuário: $e");
      return 0;
    }
  }
}
