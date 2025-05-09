import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho com saudação e carrinho
            Container(
              color: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Olá, usuário!",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Comece o dia bem com essas compras\nque selecionamos para você:",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 28,
                  ),
                ],
              ),
            ),

            // Categorias
            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                children: const [
                  CategoryItem(icon: Icons.apple, label: "Frutas"),
                  CategoryItem(icon: Icons.local_drink, label: "Bebidas"),
                  CategoryItem(icon: Icons.set_meal, label: "Carne"),
                  CategoryItem(icon: Icons.cleaning_services, label: "Limpeza"),
                ],
              ),
            ),

            // Título da seção
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Separamos algumas coisas que você pode gostar:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            // Lista de produtos
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                padding: const EdgeInsets.all(12),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: const [
                  ProductCard(
                    imagePath: 'assets/images/ovos.png',
                    title: 'Caixa de ovos',
                    price: 'R\$24,90',
                    market: 'No supermercado Maior',
                  ),
                  ProductCard(
                    imagePath: 'assets/images/carne.png',
                    title: 'Carne fresca',
                    price: 'R\$39,90',
                    market: 'No mercado da Vila',
                  ),
                  ProductCard(
                    imagePath: 'assets/images/chocolate.png',
                    title: 'Chocolate',
                    price: 'R\$4,50',
                    market: 'Mercado Bom',
                  ),
                  ProductCard(
                    imagePath: 'assets/images/carne2.png',
                    title: 'Costela bovina',
                    price: 'R\$59,00',
                    market: 'Mercado Central',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Barra de navegação inferior
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Comprar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Bolsa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: "Pedido",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}

// Componente para categorias
class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(icon, size: 30),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

// Componente para os cards de produtos
class ProductCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final String market;

  const ProductCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.market,
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
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imagePath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(price, style: const TextStyle(color: Colors.green)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              market,
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
