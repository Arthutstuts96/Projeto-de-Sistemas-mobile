import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/domain/models/order/deliver_data.dart';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';

class ShopperOrderScreen extends StatefulWidget {
  const ShopperOrderScreen({super.key});

  @override
  State<ShopperOrderScreen> createState() => _ShopperOrderScreenState();
}

class _ShopperOrderScreenState extends State<ShopperOrderScreen> {
  Order? order = Order(
    numeroPedido: "23414",
    statusPagamento: "pendente",
    statusPedido: "pendente",
    valorTotal: 213.32,
    criadoEm: DateTime.now(),
    itens: [],
    dadosEntrega: null,
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
              ? Center(child: Text("Você não está separando nenhum pedido no momento", textAlign: TextAlign.center,))
              : Container(width: 200, color: Colors.green)
    );
  }
}
