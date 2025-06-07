import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projeto_de_sistemas/domain/models/order/deliver_data.dart';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';
import 'package:projeto_de_sistemas/domain/models/order/order_item.dart';
import 'package:projeto_de_sistemas/screens/components/icon_row.dart';
import 'package:projeto_de_sistemas/screens/components/shopper/order/order_details_unchecked.dart';

class ShopperOrderScreen extends StatefulWidget {
  const ShopperOrderScreen({super.key});

  @override
  State<ShopperOrderScreen> createState() => _ShopperOrderScreenState();
}

class _ShopperOrderScreenState extends State<ShopperOrderScreen> {
  Order? order = Order(
    numeroPedido: "243242342343414",
    statusPagamento: "pendente",
    statusPedido: "pendente",
    valorTotal: 213.32,
    criadoEm: DateTime.now(),
    descricao: "Quero mais é que você se foda meu amigo",
    itens: [
      OrderItem(quantidade: 1, precoUnitario: 10.00, disponibilidade: true),
      OrderItem(quantidade: 1, precoUnitario: 5.00, disponibilidade: true),
      OrderItem(quantidade: 1, precoUnitario: 10.00, disponibilidade: true),
      OrderItem(quantidade: 1, precoUnitario: 10.00, disponibilidade: true),
      OrderItem(quantidade: 1, precoUnitario: 10.00, disponibilidade: true),
      OrderItem(quantidade: 1, precoUnitario: 10.00, disponibilidade: true),
      OrderItem(quantidade: 1, precoUnitario: 10.00, disponibilidade: true),
      OrderItem(quantidade: 1, precoUnitario: 10.00, disponibilidade: true),
      OrderItem(quantidade: 1, precoUnitario: 10.00, disponibilidade: true),
      OrderItem(quantidade: 1, precoUnitario: 10.00, disponibilidade: true),
      OrderItem(quantidade: 1, precoUnitario: 10.00, disponibilidade: true),
    ],
    dadosEntrega: DeliverData(pedidoId: 0, tipoVeiculo: "", enderecoId: 0),
  );
  // Order? order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: const EdgeInsets.symmetric(horizontal: 8),
        backgroundColor: Color.fromARGB(255, 228, 35, 35),
        title: const Text(
          "Pedido atual",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.history_outlined,
              size: 36,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body:
          order == null
              ? Center(
                child: Text(
                  "Você não está separando nenhum pedido no momento",
                  textAlign: TextAlign.center,
                ),
              )
              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      children: [
                        Text(
                          "Você está separando os itens dessa compra: ${order!.numeroPedido}",
                        ),
                        Column(
                          spacing: 4,
                          children: [
                            IconRow(
                              title: "Cliente: Null",
                              icon: Icon(Icons.person, size: 20),
                            ),
                            IconRow(
                              title:
                                  "Ativo desde: ${order!.criadoEm.toLocal().toString()}",
                              icon: Icon(Icons.timer, size: 20),
                            ),
                            IconRow(
                              title: "Comentário do cliente:",
                              icon: Icon(Icons.chat, size: 20),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: 28 * 3, //3 linhas
                          margin: EdgeInsets.all(4),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(255, 155, 191, 255),
                          ),
                          child: Text(
                            order?.descricao ??
                                "Sem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descriçãoSem descrição",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            // style: TextStyle(color: const Color.fromARGB(255, 56, 56, 56)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(child: OrderDetailsUnchecked(order: order)),
                ],
              ),
      floatingActionButton: Container(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Color.fromARGB(255, 228, 35, 35),
            splashColor: Color.fromARGB(255, 255, 81, 0),
            child: SvgPicture.asset(
              "assets/images/shopping_cart.svg",
              semanticsLabel:
                  'Ícone de um carrinho de supermercado, indicando que nele se vê o carrinho atual de itens pegos',
              width: 40,
            ),
          ),
        ),
      ),
    );
  }
}
