import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/components/register/button.dart';
import 'package:projeto_de_sistemas/screens/finish-order-screens/finish_order_screen_four.dart';
import 'package:projeto_de_sistemas/screens/finish-order-screens/finish_order_screen_one.dart';
import 'package:projeto_de_sistemas/screens/finish-order-screens/finish_order_screen_three.dart';
import 'package:projeto_de_sistemas/screens/finish-order-screens/finish_order_screen_two.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class FinishOrderScreen extends StatefulWidget {
  const FinishOrderScreen({super.key});

  @override
  State<FinishOrderScreen> createState() => _FinishOrderScreenState();
}

class _FinishOrderScreenState extends State<FinishOrderScreen> {
  final String _selected = "Pedir agora";
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Finalize seu pedido"),
      ),
      body: Column(
        children: [
          StepProgressIndicator(
            padding: 4,
            unselectedSize: 20,
            totalSteps: 4,
            currentStep: index,
            size: 32,
            selectedColor: Color(0xFFFFAA00),
            unselectedColor: Colors.grey,
            customStep: (index, color, _) {
              return color == Color(0xFFFFAA00)
                  ? Container(
                    color: color,
                    child: Icon(Icons.check, color: Colors.white),
                  )
                  : Container(color: color, child: Icon(Icons.remove));
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: getScreenByIndex(),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Button(
              onPressed: () {
                if (index > 1) {
                  setState(() {
                    index--;
                  });
                }
              },
              text: "Voltar",
              color: Colors.deepOrange,
            ),
            Button(
              onPressed: () {
                if (index < 4) {
                  setState(() {
                    index++;
                  });
                }
              },
              text: "Próximo",
            ),
          ],
        ),
      ),
    );
  }

  Widget getScreenByIndex() {
    switch (index) {
      case 1:
        return FinishOrderScreenOne(selected: _selected);
      case 2:
        return FinishOrderScreenTwo();
      case 3:
        return FinishOrderScreenThree();
      case 4:
        return FinishOrderScreenFour();
    }
    return Center(child: Text('Boa'));
  }
}
// cartController.clearCart();
// refreshCart();