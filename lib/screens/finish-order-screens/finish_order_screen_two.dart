import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FinishOrderScreenTwo extends StatefulWidget {
  FinishOrderScreenTwo({super.key});

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
            Text("Valor total dos itens: R\$23,90"),
            Text("Entrega: R\$12,90"),
            Text("Adicionais: R\$0,00"),
            Text(
              "Total: R\$46,80",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
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
                //TODO: comunicação pix para pagamento
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                child: Row(
                  spacing: 8,
                  children: [
                    Icon(
                      Icons.pix,
                      color: const Color.fromARGB(255, 2, 122, 94),
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
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
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
                padding: EdgeInsets.all(12),
                child: Row(
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
