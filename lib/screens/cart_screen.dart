import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/cart_controller.dart';
import 'package:projeto_de_sistemas/domain/models/products/cart.dart';
import 'package:projeto_de_sistemas/screens/components/modals/bottom_modal.dart';
import 'package:projeto_de_sistemas/screens/components/products/cart_product.dart';
import 'package:projeto_de_sistemas/screens/order-screens/finish_order_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = CartController();
  Future<Cart?> _cart = CartController().getCart();
  double fullPrice = 0.0;

  @override
  void initState() {
    super.initState();
    refreshCart();
  }

  Future<void> refreshCart() async {
    final newCart = await cartController.getCart();

    double newFullPrice = 0.0;

    if (newCart != null) {
      for (var item in newCart.cartItems) {
        newFullPrice += item.unityPrice * item.quantityToBuy;
      }
    }

    setState(() {
      _cart = Future.value(newCart);
      fullPrice = newFullPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: const EdgeInsets.symmetric(horizontal: 8),
        backgroundColor: const Color(0xFFFFAA00),
        title: const Text(
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
            icon: const Icon(Icons.credit_card, size: 36, color: Colors.black),
          ),
        ],
      ),
      body: Stack(
        children: [
          renderCartItens(),
          BottomModal(
            fullPrice: fullPrice,
            onPressed: () {
              if (fullPrice != 0) {
                Navigator.push(context, _createRoute(const FinishOrderScreen()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Não tem nenhum item no carrinho!'), backgroundColor: Colors.redAccent,),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget renderCartItens() {
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: Image.asset(
                          "assets/images/girl/no_itens_in_bag.png",
                          width: 250,
                        ),
                      ),
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
                ),
              );
            }

            final cart = snapshot.data!;
            return RefreshIndicator(
              onRefresh: refreshCart,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 80),
                itemCount: cart.cartItems.length,
                itemBuilder: (context, index) {
                  final product = cart.cartItems[index];
                  return CartProduct(
                    product: product,
                    onDismiss: () {
                      cartController.removeItemFromCart(product: product);
                      cart.cartItems.remove(product);
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

Route _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}
