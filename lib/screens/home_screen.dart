import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';
import 'package:projeto_de_sistemas/screens/components/products/product_card.dart';
import 'package:projeto_de_sistemas/services/api/products_home.dart';
import 'package:projeto_de_sistemas/screens/components/home/category_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho com fundo laranja e texto
            Container(
              padding: const EdgeInsets.only(top: 44),
              width: double.infinity,
              color: Color(0xFFFFAA00),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),
                  const Text(
                    "Olá, usuário!",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 55),
                ],
              ),
            ),
            // Transição com fundo branco e categorias
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Transform.translate(
                    offset: const Offset(0, -37.5),
                    child: Container(
                      height: 75,
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
            ),
            // Conteúdo principal (produtos)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Separamos algumas coisas que você pode gostar:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                // Usar FutureBuilder para carregar produtos da API
                FutureBuilder<List<Product>>(
                  future: ProductControllerApi().fetchProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Erro ao carregar produtos: ${snapshot.error}',
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {});
                              },
                              child: const Text('Tentar novamente'),
                            ),
                          ],
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('Nenhum produto encontrado.'),
                      );
                    }

                    final products = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: products[index]);
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
