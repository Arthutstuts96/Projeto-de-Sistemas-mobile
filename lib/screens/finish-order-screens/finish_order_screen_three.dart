import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/domain/models/products/cart.dart';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';
import 'package:projeto_de_sistemas/screens/components/products/cart_product_no_dismiss.dart';
import 'package:projeto_de_sistemas/screens/components/register/button.dart';

// ignore: must_be_immutable
class FinishOrderScreenThree extends StatefulWidget {
  FinishOrderScreenThree({super.key, required this.order, required this.cart});
  Order order;
  Cart cart;

  @override
  State<FinishOrderScreenThree> createState() => _FinishOrderScreenThreeState();
}

class _FinishOrderScreenThreeState extends State<FinishOrderScreenThree> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text(
            "Revise os itens do carrinho",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ...mapItens(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Button(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: "Quero repensar meu carrinho!",
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<CartProductNoDismiss> mapItens() {
    return widget.cart.cartItems.map((item) {
      return CartProductNoDismiss(product: item);
    }).toList();
  }
}
