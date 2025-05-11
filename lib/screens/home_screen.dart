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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho com fundo laranja e texto
              Container(
                width: double.infinity,
                color: Colors.orange,
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
                    // Lista de categorias (metade sobre o laranja, metade sobre o branco)
                    Transform.translate(
                      offset: const Offset(
                        0,
                        -37.5,
                      ), // Metade da altura do Container (75/2)
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
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 0.9,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children:
                              products.map((product) {
                                return ProductCard(
                                  imagem: product.imagem,
                                  nome: product.nome,
                                  precoUnitario:
                                      product.precoUnitario.toString(),
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
            ],
          ),
        ),
      ),
    );
  }
}
