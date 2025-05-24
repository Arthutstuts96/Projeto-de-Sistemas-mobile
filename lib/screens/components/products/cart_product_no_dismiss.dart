import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';

class CartProductNoDismiss extends StatelessWidget {
  const CartProductNoDismiss({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    decoration: const BoxDecoration(border: Border()),
                    child: Image.network(product.imageUrl, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(text: '${product.name}\n'),
                          TextSpan(
                            text: 'R\$${product.unityPrice}\n',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          TextSpan(
                            text: "Quantidade: ${product.quantityToBuy}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
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
        const Divider(
          height: 10,
          thickness: 2,
          indent: 20,
          endIndent: 0,
          color: Color(0xFFc3c3c3),
        ),
      ],
    );
  }
}
