import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/cart_controller.dart';
import 'package:projeto_de_sistemas/domain/models/products/cart.dart';
import 'package:projeto_de_sistemas/screens/components/modals/bottom_modal.dart';
import 'package:projeto_de_sistemas/screens/components/products/cart_product.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = CartController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(horizontal: 4),
        backgroundColor: Color(0xFFFFAA00),
        title: Text(
          "Seu carrinho",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.credit_card, size: 36, color: Colors.black),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[SizedBox(height: 100)],
          ),
          BottomModal(
            onSave: () async {
              showDialog(
                context: context,
                barrierDismissible: false, 
                builder:
                    (_) => const Center(child: CircularProgressIndicator(color: Colors.orange,)),
              );
              try {
                final bool response = await cartController.saveCart(
                  cart: Cart(
                    cartItems: [],
                    orderNumber: "1",
                    client: 1,
                    paymentStatus: "Pago",
                    orderStatus: "Entregue",
                    totalValue: 1221.32,
                  ),
                );
                Navigator.pop(context); 

                if (response) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pedido salvo com sucesso!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Erro ao salvar pedido.')),
                  );
                }
              } catch (e) {
                Navigator.pop(context); 
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Erro inesperado: $e')));
              }
            },
          ),
        ],
      ),
    );
  }
}
