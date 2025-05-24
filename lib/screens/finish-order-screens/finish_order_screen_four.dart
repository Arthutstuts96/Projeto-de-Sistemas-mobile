import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/order_controller.dart';
import 'package:projeto_de_sistemas/screens/components/register/button.dart';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';

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
    widget.order.statusPedido = "ativo";

    final orderSent = await _orderController.saveOrder(order: widget.order);
    if (orderSent.toString().startsWith("2")) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Pedido enviado!'), backgroundColor: Colors.green,));
      //TODO: tela de sucesso
      // Navigator.pushReplacementNamed(context, "main_screen");
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Um erro inesperado aconteceu. Por favor, tente novamente mais tarde'), backgroundColor: Colors.redAccent,));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        const Text(
          "Deixe aqui alguma sugestão para o separador:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Container(
          height: 200,
          child: TextFormField(
            controller: _controller,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
        ),
        // const Spacer(),
        Align(
          alignment: Alignment.centerRight,
          child: Button(
            onPressed: () {
              sendOrder();
            },
            text: "Enviar pedido",
            color: Color(0xFFFFAA00),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          ),
        ),
      ],
    );
  }
}
