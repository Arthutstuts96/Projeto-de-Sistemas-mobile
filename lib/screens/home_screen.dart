import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/products_controller.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController productController = ProductController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho com saudação e carrinho + fundo branco e laranja + lista flutuante
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.orange,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 24,
                    left: 16,
                    right: 16,
                    bottom: 110,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Olá, usuário!",
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Comece o dia bem com essas compras que selecionamos para você:",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 28,
                      ),
                    ],
                  ),
                ),

                // Fundo branco por trás da lista
                Positioned(
                  top: 200,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(color: Colors.white),
                ),

                // Lista flutuante de categorias
                Positioned(
                  top: 150,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      children: [
                        CategoryButton(
                          imagePath: 'assets/images/fruta.png',
                          label: "Frutas",
                          route: '/frutas',
                        ),
                        CategoryButton(
                          imagePath: 'assets/images/Bebida.png',
                          label: "Bebidas",
                          route: '/bebidas',
                        ),
                        CategoryButton(
                          imagePath: 'assets/images/Carne.png',
                          label: "Carne",
                          route: '/carne',
                        ),
                        CategoryButton(
                          imagePath: 'assets/images/Limpeza.png',
                          label: "Limpeza",
                          route: '/limpeza',
                        ),
                        CategoryButton(
                          imagePath: 'assets/images/fruta.png',
                          label: "Padaria",
                          route: '/padaria',
                        ),
                        CategoryButton(
                          imagePath: 'assets/images/fruta.png',
                          label: "Pet Shop",
                          route: '/petshop',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Separamos algumas coisas que você pode gostar:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 0.72,
                        shrinkWrap:
                            true, // <- importante para não quebrar layout
                        physics:
                            const NeverScrollableScrollPhysics(), // <- evita conflito com o SingleChildScrollView
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: productController.getMockProducts().map((product) {
                          return ProductCard(
                            imagePath: product.imagePath,
                            title: product.title,
                            price: product.price,
                            market: product.market,
                          );
                        }).toList(),

                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

// Componente para categorias com botões
class CategoryButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final String route;

  const CategoryButton({
    super.key,
    required this.imagePath,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ElevatedButton(
        onPressed: () {
          // Navega para a rota específica quando o botão for pressionado
          Navigator.pushNamed(context, route);
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF3C3C3C), width: 1),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 40,
              width: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF3C3C3C),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
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
