import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/cart_controller.dart';
import 'package:projeto_de_sistemas/domain/models/order/deliver_data.dart';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';
import 'package:projeto_de_sistemas/domain/models/order/order_item.dart';
import 'package:projeto_de_sistemas/domain/models/products/cart.dart';
import 'package:projeto_de_sistemas/screens/components/button.dart';
import 'package:projeto_de_sistemas/screens/finish-order-screens/finish_order_screen_four.dart';
import 'package:projeto_de_sistemas/screens/finish-order-screens/finish_order_screen_one.dart';
import 'package:projeto_de_sistemas/screens/finish-order-screens/finish_order_screen_three.dart';
import 'package:projeto_de_sistemas/screens/finish-order-screens/finish_order_screen_two.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class FinishOrderScreen extends StatefulWidget {
  const FinishOrderScreen({super.key});

  @override
  State<FinishOrderScreen> createState() => _FinishOrderScreenState();
}

class _FinishOrderScreenState extends State<FinishOrderScreen> {
  final CartController _cartController = CartController();
  late Cart cart;
  final String _selected = "Pedir agora";
  double itensValorTotal = 0.0;
  int index = 1;
  Order order = Order(
    numeroPedido: '',
    statusPagamento: '',
    statusPedido: '',
    valorTotal: 0.0,
    criadoEm: DateTime.now(),
    itens: [],
    dadosEntrega: DeliverData(pedidoId: 0, tipoVeiculo: "", enderecoId: 0),
    // mercadoLatitude: 0.0,
    // mercadoLongitude: 0.0,
    // clientLatitude: 0.0,
    // clientLongitude: 0.0,
    enderecoEntrega: '',
  );

  @override
  void initState() {
    super.initState();
    getCart();
  }

  void getCart() async {
    cart = (await _cartController.getCart())!;

    order.numeroPedido = cart.orderNumber;
    order.itens =
        cart.cartItems
            .map(
              (item) => OrderItem(
                disponibilidade: true,
                precoUnitario: item.unityPrice,
                quantidade: item.quantityToBuy,
                produtoId: item.id,
              ),
            )
            .toList();
    for (var item in order.itens) {
      itensValorTotal += item.precoUnitario * item.quantidade;
    }
    order.valorTotal = itensValorTotal + 19.90;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Finalize seu pedido"),
      ),
      body: Column(
        children: [
          StepProgressIndicator(
            padding: 4,
            unselectedSize: 20,
            totalSteps: 4,
            currentStep: index,
            size: 28,
            selectedColor: const Color(0xFFFFAA00),
            unselectedColor: Colors.grey,
            customStep: (index, color, _) {
              return color == const Color(0xFFFFAA00)
                  ? Container(
                    color: color,
                    child: const Icon(Icons.check, color: Colors.white),
                  )
                  : Container(color: color, child: const Icon(Icons.remove));
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: getScreenByIndex(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Button(
              onPressed: () {
                if (index > 1) {
                  setState(() {
                    index--;
                  });
                }
              },
              text: "Voltar",
              color: Colors.deepOrange,
            ),
            Button(
              onPressed: () {
                if (index < 4) {
                  setState(() {
                    index++;
                  });
                }
              },
              text: "Próximo",
            ),
          ],
        ),
      ),
    );
  }

  Widget getScreenByIndex() {
    switch (index) {
      case 1:
        return FinishOrderScreenOne(selected: _selected, order: order);
      case 2:
        return FinishOrderScreenTwo(
          order: order,
          deliverPrice: _selected == "Pedir agora" ? 19.90 : 12.90,
          itensPrice: itensValorTotal,
        );
      case 3:
        return FinishOrderScreenThree(order: order, cart: cart);
      case 4:
        return FinishOrderScreenFour(order: order);
    }
    return const Center(
      child: Text('Parece que não há nada para fazer aqui...'),
    );
  }
}
// cartController.clearCart();
// refreshCart();