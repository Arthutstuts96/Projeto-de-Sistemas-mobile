import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/components/market/card_market.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [CardMarket(), CardMarket()]);
  }
}
