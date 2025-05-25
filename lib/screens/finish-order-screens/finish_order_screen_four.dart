import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/order_controller.dart';
import 'package:projeto_de_sistemas/screens/components/register/button.dart';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';
import 'package:projeto_de_sistemas/screens/order-screens/order_success_screen.dart';

// 1. IMPORTE O PROVIDER E SEU ACTIVE_DELIVERY_CONTROLLER
import 'package:provider/provider.dart';
import 'package:projeto_de_sistemas/controllers/active_delivery_controller.dart'; // Verifique o caminho correto

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
    widget.order.statusPagamento =
        "pendente"; // Ajuste conforme sua lógica real
    widget.order.statusPedido =
        "ativo"; // Ou "aguardando_confirmacao_mercado", etc.

    final orderSent = await _orderController.saveOrder(order: widget.order);

    // Verifica se o contexto ainda está montado antes de interagir com ele
    if (!mounted) return;

    if (orderSent.toString().startsWith("2")) {
      // Supondo que '2xx' indica sucesso
      // 2. AQUI VOCÊ DISPARA A SIMULAÇÃO PARA O ENTREGADOR
      // Esta linha "cria" a tarefa simulada que o entregador poderá ver.
      Provider.of<ActiveDeliveryController>(
        context,
        listen: false,
      ).simulateNewTaskAvailable();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Pedido enviado! Tarefa de entrega simulada para o entregador.',
          ),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        // Usar pushReplacement para não voltar para a tela de finalizar pedido
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
      // Removi o atributo 'spacing' pois Column não o possui diretamente.
      // Use SizedBox ou Padding para espaçamento.
      children: [
        const Text(
          "Deixe aqui alguma sugestão para o separador:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(height: 12), // Adicionado SizedBox para espaçamento
        Container(
          height: 200, // Altura definida para o TextFormField
          child: TextFormField(
            controller: _controller,
            maxLines: null, // Permite múltiplas linhas
            expands:
                true, // Faz o TextFormField expandir para preencher o Container
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              hintText:
                  "Ex: deixar sem cebola, troco para R\$50...", // Adicionado hintText
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ), // Adicionado SizedBox para espaçamento antes do botão
        Align(
          alignment: Alignment.centerRight,
          child: Button(
            // Seu componente Button customizado
            onPressed: () {
              sendOrder();
            },
            text: "Enviar pedido",
            // color: Color(0xFFFFAA00), // A cor já deve estar no seu Button
            // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24), // Padding já deve estar no seu Button
          ),
        ),
      ],
    );
  }
}
