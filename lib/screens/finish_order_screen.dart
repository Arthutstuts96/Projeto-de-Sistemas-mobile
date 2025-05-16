import 'package:flutter/material.dart';

class FinishOrderScreen extends StatelessWidget {
  const FinishOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
        title: Text("Finalize seu pedido"),
      ),
    );
  }
}
// cartController.clearCart();
// refreshCart();