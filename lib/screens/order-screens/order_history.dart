import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/components/order/card_order_history.dart';
import 'package:universal_stepper/universal_stepper.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "Histórico de pedidos",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          UniversalStepper(
            inverted: false,
            stepperDirection: Axis.vertical,
            elementBuilder: (context, index) {
              return Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 12, bottom: 16),
                  child: const CardOrderHistory(),
                ),
              );
            },
            badgeBuilder: (context, index) {
              return Container(
                width: 30,
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(28)),
                ),
                child: const FittedBox(
                  child: Icon(Icons.fastfood, color: Colors.white),
                ),
              );
            },
            pathBuilder: (context, index) {
              return Container(
                color:
                    index == 2 - 1
                        ? Colors.transparent
                        : (index < 5 ? Colors.green : Colors.grey),
                width: 4,
              );
            },
            subPathBuilder: (context, index) {
              return Container(
                color:
                    index == 2 - 1
                        ? Colors.transparent
                        : (index < 5 ? Colors.green : Colors.grey),
                width: 4,
              );
            },
            elementCount: 2 - 1,
            badgePosition: StepperBadgePosition.start,
          ),
        ],
      ),
    );
  }
}
