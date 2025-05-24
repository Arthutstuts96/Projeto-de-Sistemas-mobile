import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';
import 'package:projeto_de_sistemas/screens/components/products/change_quantity_button.dart';

class CartProduct extends StatelessWidget {
  const CartProduct({super.key, required this.product, required this.onDismiss});
  final Product product;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key("Asas"),
      onDismissed: (direction) {
        onDismiss();
      },
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.cancel, size: 30, color: Colors.white),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 124,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          width: 140.0,
                          decoration: BoxDecoration(
                            border: Border()
                          ),
                          child: Image.network(
                            product.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 200),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(text: '${product.name}\n'),
                                TextSpan(
                                  text: 'R\$${product.unityPrice}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 12,
                right: 12,
                child: ChangeQuantityButton(quantity: product.quantityToBuy),
              ),
            ],
          ),
          const Divider(
            height: 10,
            thickness: 2,
            indent: 20,
            endIndent: 0,
            color: Color(0xFFc3c3c3),
          ),
        ],
      ),
    );
  }
}
