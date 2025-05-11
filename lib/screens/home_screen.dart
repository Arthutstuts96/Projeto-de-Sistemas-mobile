import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';
import 'package:projeto_de_sistemas/services/api/products.dart';
import 'package:projeto_de_sistemas/screens/components/home/product_card.dart';
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
                  color: Colors.orange, // Fundo laranja preservado
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
                  child: Container(
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
                    // Usar FutureBuilder para carregar produtos da API
                    FutureBuilder<List<Product>>(
                      future: ProductControllerApi().fetchProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          // Exibir indicador de carregamento
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          // Exibir mensagem de erro
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
                                    // Forçar recarregamento ao clicar
                                    setState(() {});
                                  },
                                  child: const Text('Tentar novamente'),
                                ),
                              ],
                            ),
                          );
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          // Exibir mensagem se não houver produtos
                          return const Center(
                            child: Text('Nenhum produto encontrado.'),
                          );
                        }

                        // Exibir produtos no GridView
                        final products = snapshot.data!;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: 0.9, // Ajustado para menos espaço vertical
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            children: products.map((product) {
                              return ProductCard(
                                imagem: product.imagem,
                                nome: product.nome,
                                precoUnitario: product.precoUnitario.toString(),
                                marca: product.marca,
                              );
                            }).toList(),
                          ),
                        );
                      },
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