import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String nome;
  final String precoUnitario;
  final String marca;
  final String imagem;
  const ProductCard({
    super.key,
    required this.nome,
    required this.precoUnitario,
    required this.marca,
    required this.imagem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder no lugar da imagem
          Container(
            margin: const EdgeInsets.only(left: 40),
            width: 100,
            height: 100,
            alignment: Alignment.centerRight,
            child: Image.network(imagem, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              nome,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'R\$$precoUnitario',
              style: const TextStyle(color: Colors.green),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              marca,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.star_border),
                Icon(Icons.shopping_bag_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
