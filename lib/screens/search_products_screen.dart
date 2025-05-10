import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';
import 'package:projeto_de_sistemas/screens/cart_screen.dart';
import 'package:projeto_de_sistemas/screens/components/products/product_card.dart';

class SearchProductsScreen extends StatelessWidget {
  const SearchProductsScreen({super.key});

  static List<Product> mockProducts = [
    Product(
      id: 1,
      name: 'Smartphone X',
      description: 'Smartphone de última geração',
      category: 'Eletrônicos',
      brand: 'TechBrand',
      market: 'TechStore',
      unityPrice: 599.99,
      quantity: 1,
      expirationDate: DateTime(2026, 12, 31),
      image: '',
      barCode: 1000001,
    ),
    Product(
      id: 2,
      name: 'Wireless Headphones',
      description: 'Fones de ouvido sem fio com alta qualidade',
      category: 'Eletrônicos',
      brand: 'AudioBrand',
      market: 'AudioShop',
      unityPrice: 129.99,
      quantity: 1,
      expirationDate: DateTime(2026, 12, 31),
      image: '',
      barCode: 1000002,
    ),
    Product(
      id: 3,
      name: 'Smart Watch',
      description: 'Relógio inteligente com monitoramento de saúde',
      category: 'Eletrônicos',
      brand: 'GadgetBrand',
      market: 'GadgetZone',
      unityPrice: 199.99,
      quantity: 1,
      expirationDate: DateTime(2026, 12, 31),
      image: '',
      barCode: 1000003,
    ),
    Product(
      id: 4,
      name: 'Smartphone X',
      description: 'Smartphone de última geração',
      category: 'Eletrônicos',
      brand: 'TechBrand',
      market: 'TechStore',
      unityPrice: 599.99,
      quantity: 1,
      expirationDate: DateTime(2026, 12, 31),
      image: '',
      barCode: 1000004,
    ),
    Product(
      id: 5,
      name: 'Wireless Headphones',
      description: 'Fones de ouvido sem fio com alta qualidade',
      category: 'Eletrônicos',
      brand: 'AudioBrand',
      market: 'AudioShop',
      unityPrice: 129.99,
      quantity: 1,
      expirationDate: DateTime(2026, 12, 31),
      image: '',
      barCode: 1000005,
    ),
    Product(
      id: 6,
      name: 'Smart Watch',
      description: 'Relógio inteligente com monitoramento de saúde',
      category: 'Eletrônicos',
      brand: 'GadgetBrand',
      market: 'GadgetZone',
      unityPrice: 199.99,
      quantity: 1,
      expirationDate: DateTime(2026, 12, 31),
      image: '',
      barCode: 1000006,
    ),
    Product(
      id: 7,
      name: 'Smartphone X',
      description: 'Smartphone de última geração',
      category: 'Eletrônicos',
      brand: 'TechBrand',
      market: 'TechStore',
      unityPrice: 599.99,
      quantity: 1,
      expirationDate: DateTime(2026, 12, 31),
      image: '',
      barCode: 1000007,
    ),
    Product(
      id: 8,
      name: 'Wireless Headphones',
      description: 'Fones de ouvido sem fio com alta qualidade',
      category: 'Eletrônicos',
      brand: 'AudioBrand',
      market: 'AudioShop',
      unityPrice: 129.99,
      quantity: 1,
      expirationDate: DateTime(2026, 12, 31),
      image: '',
      barCode: 1000008,
    ),
    Product(
      id: 9,
      name: 'Smart Watch',
      description: 'Relógio inteligente com monitoramento de saúde',
      category: 'Eletrônicos',
      brand: 'GadgetBrand',
      market: 'GadgetZone',
      unityPrice: 199.99,
      quantity: 1,
      expirationDate: DateTime(2026, 12, 31),
      image: '',
      barCode: 1000009,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFAA00),
        title: Text("Procurar por item/mercado"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            icon: Icon(Icons.filter_alt_outlined, size: 35),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Pesquisar...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Resultados",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    spacing: 4,
                    children: <ElevatedButton>[
                      ElevatedButton(onPressed: () {}, child: Text("Item")),
                      ElevatedButton(onPressed: () {}, child: Text("Mercado")),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                shrinkWrap: true, // <- importante para não quebrar layout
                physics:
                    const NeverScrollableScrollPhysics(), // <- evita conflito com o SingleChildScrollView
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children:
                    mockProducts.map((product) {
                      return ProductCard(product: product,);
                    }).toList(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
