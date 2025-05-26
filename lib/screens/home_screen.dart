import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';
import 'package:projeto_de_sistemas/controllers/products_controller.dart'; // Controller novo
import 'package:projeto_de_sistemas/screens/components/products/product_card.dart';
import 'package:projeto_de_sistemas/screens/components/home/category_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// 1. ADICIONAR AutomaticKeepAliveClientMixin
class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  // 2. MANTER ESTADO VIVO
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // 3. BUSCAR PRODUTOS NA PRIMEIRA VEZ (se não foram buscados ainda)
    //    OU SE VOCÊ QUISER QUE SEMPRE ATUALIZE AO ENTRAR NA TELA INICIALMENTE
    //    (MAS O PULL-TO-REFRESH SERÁ A FORMA PRINCIPAL DE ATUALIZAÇÃO APÓS A PRIMEIRA CARGA)
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

  // 4. MÉTODO PARA O RefreshIndicator
  Future<void> _handleRefresh() async {
    await Provider.of<HomeProductsController>(
      context,
      listen: false,
    ).fetchProducts(forceRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    // 5. CHAMAR super.build(context)
    super.build(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F4FA),
      body: Consumer<HomeProductsController>(
        // 6. USAR CONSUMER PARA REAGIR ÀS MUDANÇAS
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
            // 7. ADICIONAR RefreshIndicator
            onRefresh: _handleRefresh,
            child: SingleChildScrollView(
              physics:
                  const AlwaysScrollableScrollPhysics(), // Permite o scroll mesmo com poucos itens para o RefreshIndicator funcionar
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
                          "Olá, usuário!",
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
                            height: 75,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              children: const [
                                // Seus CategoryButton podem ser const se não mudam
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
                                ), // Ajuste o imagePath se necessário
                                CategoryButton(
                                  imagePath: 'assets/images/fruta.png',
                                  label: "Pet Shop",
                                  route: '/petshop',
                                ), // Ajuste o imagePath se necessário
                              ],
                            ),
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
                      // 8. USAR A productSection AQUI
                      productSection,
                      const SizedBox(height: 20),
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
