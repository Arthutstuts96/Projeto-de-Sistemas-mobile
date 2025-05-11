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
  Future<Cart?> _cart = CartController().getCart();

  Future<void> refreshCart() async {
    setState(() {
      _cart = cartController.getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(horizontal: 8),
        backgroundColor: Color(0xFFFFAA00),
        title: Text(
          "Seu carrinho",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 24,
          ),
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
          getCartItens(),
          SizedBox(height: 100),
          BottomModal(
            onSave: () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder:
                    (c) => const Center(
                      child: CircularProgressIndicator(color: Colors.orange),
                    ),
              );
              try {
                // final bool response = await cartController.saveCart(
                //   cart: Cart(
                //     cartItems: [],
                //     orderNumber: "1",
                //     client: 1,
                //     paymentStatus: "Pago",
                //     orderStatus: "Entregue",
                //     totalValue: 1221.32,
                //   ),
                // );
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pedido salvo com sucesso!'), backgroundColor: Colors.lightGreen,),
                  );
                  cartController.clearCart();
                });
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

  Widget getCartItens() {
    return FutureBuilder<Cart?>(
      future: _cart,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.active:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data == null ||
                snapshot.data!.cartItems.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(56),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        "assets/images/no_itens_in_bag.png",
                        width: 250,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Não tem itens no carrinho. Adicione alguma coisa para vê-la aqui!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 151, 151, 151),
                      ),
                    ),
                  ],
                ),
              );
            }

            final cart = snapshot.data!;
            return RefreshIndicator(
              onRefresh: refreshCart,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: cart.cartItems.length,
                itemBuilder: (context, index) {
                  final product = cart.cartItems[index];
                  return CartProduct(
                    product: product,
                    onDismiss: () {
                      cartController.removeItemFromCart(product: product);
                    },
                  );
                },
              ),
            );
        }
      },
    );
  }
}
