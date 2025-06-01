import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/cart_controller.dart';
import 'package:projeto_de_sistemas/screens/components/register/button.dart';

class OrderSuccessScreen extends StatelessWidget {
  OrderSuccessScreen({super.key});
  final CartController _cartController = CartController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12,
          children: [
            Image.asset("assets/images/girl/girl_success_jumping.png", width: 160),
            const Text(
              "Sucesso!",
              style: TextStyle(
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Seu pedido foi registrado e em breve um separador irá separá-lo para você!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            // const Text(
            //   "Lembre-se de efetuar o pagamento caso ainda não o tenha feito!",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 14, color: Colors.redAccent),
            // ),
            Button(
              onPressed: () async{
                await _cartController.clearCart();                
                Navigator.pushReplacementNamed(context, "main_screen");
              },
              text: "Retornar para a home",
            ),
          ],
        ),
      ),
    );
  }
}
