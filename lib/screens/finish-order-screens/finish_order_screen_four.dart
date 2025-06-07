// lib/screens/finish-order-screens/finish_order_screen_four.dart
import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/order_controller.dart';
import 'package:projeto_de_sistemas/screens/components/register/button.dart';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';
import 'package:projeto_de_sistemas/screens/order-screens/order_success_screen.dart';
import 'package:provider/provider.dart';
import 'package:projeto_de_sistemas/controllers/active_delivery_controller.dart'; // Verifique o caminho

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
      // Coletar dados para o DeliveryTaskMock
      String itensResumo = widget.order.itens
          .map((item) {
            // Idealmente, você teria o nome do produto aqui.
            // Por agora, vamos usar o ID ou uma descrição genérica.
            return "${item.quantidade}x (Produto ID: ${item.produtoId})";
          })
          .join(', ');

      // Use o endereço salvo no objeto order
      String enderecoEntrega =
          widget.order.enderecoEntrega ?? "Endereço não fornecido";

      // Nome do cliente (se você tiver essa informação no app, senão um placeholder)
      String nomeCliente =
          "Cliente do Pedido"; // Ex: Pegar de um UserProvider.currentUser.name

      Provider.of<ActiveDeliveryController>(
        context,
        listen: false,
      ).simulateNewTaskAvailable(
        orderId:
            widget.order.numeroPedido.isNotEmpty
                ? widget.order.numeroPedido
                : "PED_SIMULADO",
        customerName: nomeCliente, // Substitua por nome real se tiver
        deliveryAddress: enderecoEntrega,
        itemsSummary: itensResumo,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Pedido enviado! Tarefa de entrega simulada para o entregador.',
          ),
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
        SizedBox(height: 12),
        Container(
          height: 200,
          child: TextFormField(
            controller: _controller,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              hintText: "Ex: deixar sem cebola, troco para R\$50...",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
        ),
        SizedBox(height: 12),
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
