import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/order_controller.dart';
import 'package:projeto_de_sistemas/controllers/shopper_controller.dart';
import 'package:projeto_de_sistemas/screens/components/button.dart';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';
import 'package:projeto_de_sistemas/screens/order-screens/order_success_screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FinishOrderScreenFour extends StatefulWidget {
  FinishOrderScreenFour({super.key, required this.order});
  Order order;

  @override
  State<FinishOrderScreenFour> createState() => _FinishOrderScreenFourState();
}

class _FinishOrderScreenFourState extends State<FinishOrderScreenFour> {
  final TextEditingController _controller = TextEditingController();
  final OrderController _orderController = OrderController();

  void sendOrder() async {
    widget.order.descricao = _controller.text;
    widget.order.criadoEm = DateTime.now();
    widget.order.statusPagamento = "pendente";
    widget.order.statusPedido = "pendente";
    final orderSent = await _orderController.saveOrder(order: widget.order);

    if (!mounted) return;

    if (orderSent.toString().startsWith("2")) {
      String enderecoEntrega =
          widget.order.enderecoEntrega ?? "Endereço não fornecido";
      String nomeCliente = "Cliente do Pedido";

      // Chama o separador
      Provider.of<ShopperController>(
        context,
        listen: false,
      ).addNewSeparationTask(
        orderId:
            widget.order.numeroPedido.isNotEmpty
                ? widget.order.numeroPedido
                : "PED_SIMULADO",
        customerName: nomeCliente,
        deliveryAddress: enderecoEntrega,
        items: widget.order.itens,
        mercadoLatitude: widget.order.mercadoLatitude ?? 0.0,
        mercadoLongitude: widget.order.mercadoLongitude ?? 0.0,
        clientLatitude: widget.order.clientLatitude ?? 0.0,
        clientLongitude: widget.order.clientLongitude ?? 0.0,
        criadoEm: DateTime.now(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pedido enviado! O separador já foi notificado.'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OrderSuccessScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Um erro inesperado aconteceu. Por favor, tente novamente mais tarde',
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Deixe aqui alguma sugestão para o separador:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 12),
        Container(
          height: 200,
          child: TextFormField(
            controller: _controller,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            decoration: const InputDecoration(
              hintText: "Ex: deixar sem cebola, troco para R\$50...",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: Button(
            onPressed: () {
              sendOrder();
            },
            text: "Enviar pedido",
          ),
        ),
      ],
    );
  }
}
