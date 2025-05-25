import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';
import 'package:universal_stepper/universal_stepper.dart';

class CurrentOrder extends StatelessWidget {
  const CurrentOrder({super.key, required this.order});
  final Order? order;

  @override
  Widget build(BuildContext context) {
    final stepWidgets = [
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pedido recebido",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            "Estamos procurando um separador para pegar a sua compra",
            style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
          ),
          SizedBox(height: 36),
        ],
      ),
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Compra separada e pronta para o envio",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            "Estamos procurando um entregador para levá-la ao seu endereço",
            style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
          ),
          SizedBox(height: 36),
        ],
      ),
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "A caminho",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            "O entregador já saiu para o endereço com sua compra",
            style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
          ),
          SizedBox(height: 36),
        ],
      ), //
      const Text(
        "Chegou!",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ];

    if(order == null){
      return const Center(
        child: Text("Não há nenhum pedido ativo no momento."),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "Pedido atual",
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
                  child: stepWidgets[index],
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
                child: FittedBox(
                  child: Icon(
                    index == stepWidgets.length - 1
                        ? Icons.home
                        : Icons.thumb_up,
                    color: Colors.white,
                  ),
                ),
              );
            },
            pathBuilder: (context, index) {
              return Container(
                color:
                    index == stepWidgets.length - 1
                        ? Colors.transparent
                        : (index < 5 ? Colors.green : Colors.grey),
                width: 4,
              );
            },
            subPathBuilder: (context, index) {
              return Container(
                color:
                    index == stepWidgets.length - 1
                        ? Colors.transparent
                        : (index < 5 ? Colors.green : Colors.grey),
                width: 4,
              );
            },
            elementCount: stepWidgets.length,
            badgePosition: StepperBadgePosition.start,
          ),
        ],
      ),
    );
  }
}
