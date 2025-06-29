import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/cart_controller.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';
import 'package:projeto_de_sistemas/utils/functions/format_functions.dart';

class ProductCard extends StatelessWidget {
  ProductCard({super.key, required this.product});
  final Product product;

  final CartController cartController = CartController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'product_screen', arguments: product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Center(
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.contain,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/images/no-image.jpg",
                      fit: BoxFit.cover,
                      height: 100,
                    );
                  },
                ),
                // child:
                //     product.imageUrl.isNotEmpty
                //         ? Image.network(
                //           product.imageUrl,
                //           height: 100,
                //           fit: BoxFit.cover,
                //         )
                //         : Image.asset("assets/images/no-image.jpg"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "R\$${formatMonetary(product.unityPrice)}",
                style: const TextStyle(color: Colors.green),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                product.brand,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <IconButton>[
                  IconButton(onPressed: () {}, icon: Icon(Icons.star_border)),
                  IconButton(
                    onPressed: () async {
                      final bool response = await cartController.addItemToCart(
                        product: product,
                      );
                      if (response) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Item salvo com sucesso no carrinho!',
                            ),
                            backgroundColor: Colors.lightGreen,
                          ),
                        );
                      }
                    },
                    icon: Icon(Icons.shopping_bag_outlined),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Caso dê conflito: mudei definida largura horizontal fixa e não quebra linha para textos
