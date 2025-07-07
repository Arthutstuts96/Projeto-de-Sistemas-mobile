import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_de_sistemas/controllers/products_controller.dart';
import 'package:projeto_de_sistemas/screens/components/products/product_card.dart';
import 'package:projeto_de_sistemas/screens/components/home/category_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Provider.of<HomeProductsController>(
        context,
        listen: false,
      );
      if (!controller.hasFetchedOnce) {
        // Só busca se nunca buscou antes
        controller.fetchProducts();
      }
    });
  }

  Future<void> _handleRefresh() async {
    await Provider.of<HomeProductsController>(
      context,
      listen: false,
    ).fetchProducts(forceRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F4FA),
      body: Consumer<HomeProductsController>(
        builder: (context, controller, child) {
          Widget productSection;

          if (controller.isLoading && controller.products.isEmpty) {
            // Loading inicial
            productSection = const Center(child: CircularProgressIndicator());
          } else if (controller.error != null) {
            productSection = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Erro ao carregar produtos: ${controller.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed:
                        () => controller.fetchProducts(forceRefresh: true),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          } else if (controller.products.isEmpty && !controller.isLoading) {
            productSection = const Center(
              child: Text('Nenhum produto encontrado.'),
            );
          } else {
            // Grid de produtos
            productSection = Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // O scroll principal será do RefreshIndicator/SingleChildScrollView
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: controller.products[index]);
                },
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _handleRefresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 44),
                    width: double.infinity,
                    color: const Color(0xFFFFAA00),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 25),
                        Text(
                          "Olá, bem-vindo!",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 55),
                      ],
                    ),
                  ),
                  Container(
                    color: const Color(0xFFF9F4FA),
                    child: Column(
                      children: [
                        Transform.translate(
                          offset: const Offset(0, -37.5),
                          child: SizedBox(
                            height: 85,
                            child: Consumer<HomeProductsController>(
                              // <--- Consumer aqui
                              builder: (context, controller, child) {
                                // Se as categorias ainda não foram carregadas, pode mostrar um Shimmer ou CircularProgressIndicator
                                if (controller.categories.isEmpty) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  ); // Ou um placeholder
                                }
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  itemCount: controller.categories.length,
                                  itemBuilder: (context, index) {
                                    if (index < 0 ||
                                        index >= controller.categories.length) {
                                      print(
                                        'DEBUG ERRO CRÍTICO: ListView builder solicitou Index $index fora dos limites da lista de Length ${controller.categories.length}',
                                      );
                                      return const SizedBox.shrink(); // Retorna widget vazio se o index for inválido.
                                    }

                                    print(
                                      'DEBUG: Processando Categoria - Index: $index, ID: ${controller.categories[index].id}, Name: ${controller.categories[index].name}, Ajuda ai Deus',
                                    );

                                    final category =
                                        controller
                                            .categories[index]; // LINHA 151
                                    String imagePath;
                                    String displayName;

                                    switch (category.id) {
                                      case "all_products_category_id_unique":
                                        imagePath =
                                            'assets/images/all_products.png';
                                        displayName = 'Todos';
                                        break;
                                      case "1":
                                        imagePath = 'assets/images/graos.png';
                                        displayName = 'Grãos';
                                        break;
                                      case "2":
                                        imagePath = 'assets/images/carnes.png';
                                        displayName = 'Carnes';
                                        break;
                                      case "3":
                                        imagePath =
                                            'assets/images/enlatados.png';
                                        displayName = 'Enlatados';
                                        break;
                                      case "4":
                                        imagePath = 'assets/images/bebidas.png';
                                        displayName = 'Bebidas';
                                        break;
                                      case "5":
                                        imagePath = 'assets/images/frutas.png';
                                        displayName = 'Hortifruti';
                                        break;
                                      case "6":
                                        imagePath = 'assets/images/doces.png';
                                        displayName = 'Doces';
                                        break;
                                      case "7":
                                        imagePath =
                                            'assets/images/laticinios.png';
                                        displayName = 'Laticínios';
                                        break;
                                      case "8":
                                        imagePath =
                                            'assets/images/temperos.png';
                                        displayName = 'Temperos';
                                        break;
                                      default:
                                        imagePath =
                                            'assets/images/default_category.png';
                                        displayName = 'Outros';
                                        break;
                                    }

                                    return CategoryButton(
                                      key: ValueKey(
                                        category.id,
                                      ), // <--- Adicione uma Key ÚNICA ao item
                                      imagePath: imagePath,
                                      label: displayName,
                                      onTap:
                                          () => controller.setSelectedCategory(
                                            category.name,
                                          ),
                                    );
                                  },
                                );
                              },
                            ), // <--- Fim do Consumer
                          ),
                        ),
                      ],
                    ),
                  ),
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
                      productSection,
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
