import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';
import 'package:projeto_de_sistemas/utils/widgets/generate_pix.dart';

// ignore: must_be_immutable
class FinishOrderScreenTwo extends StatefulWidget {
  FinishOrderScreenTwo({
    super.key,
    required this.order,
    this.deliverPrice = 0,
    this.itensPrice = 0,
  });
  Order order;
  final double itensPrice;
  final double deliverPrice;

  @override
  State<FinishOrderScreenTwo> createState() => _FinishOrderScreenTwoState();
}

class _FinishOrderScreenTwoState extends State<FinishOrderScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        const Text(
          "Resumo da compra",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Valor total dos itens: R\$${widget.itensPrice.toStringAsFixed(2).replaceAll(".", ",")}",
            ),
            Text(
              "Entrega: R\$${widget.deliverPrice.toStringAsFixed(2).replaceAll(".", ",")}",
            ),
            const Text("Adicionais: R\$0,00"),
            Text(
              "Total: R\$${(widget.itensPrice + widget.deliverPrice).toStringAsFixed(2).replaceAll(".", ",")}",
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ],
        ),
        const Text(
          "Método de pagamento",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Column(
          children: [
            InkWell(
              onTap: () {
                showPixDialog(context);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: const Row(
                  spacing: 8,
                  children: [
                    Icon(
                      Icons.pix,
                      color: Color.fromARGB(255, 2, 122, 94),
                    ),
                    Text("Pix", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'A função de pagar pelo cartão ainda não está disponível',
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        Icon(Icons.credit_card),
                        Text(
                          "Cartão de Crédito",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Icon(Icons.block),
                  ],
                ),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'A função de pagamentos pelo cartão ainda não está disponível!',
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        Icon(Icons.card_membership),
                        Text(
                          "Cartão de Débito",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Icon(Icons.block),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
