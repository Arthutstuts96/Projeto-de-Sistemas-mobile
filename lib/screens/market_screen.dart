import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/products_controller.dart';
import 'package:projeto_de_sistemas/domain/models/market.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';
import 'package:projeto_de_sistemas/screens/components/products/product_card.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key, required this.market});
  final Market market;

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  late Future<List<dynamic>> _searchFuture;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _searchFuture = _fetchData();
  }

  Future<List<dynamic>> _fetchData() async {
    final products = await ProductController().fetchProducts();
    return _filterProductList(products);
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _searchFuture = _fetchData();
    });
  }

  List<Product> _filterProductList(List<Product> list) {
    return list.where((product) {
      final value = removeDiacritics(product.name.toLowerCase());
      final query = removeDiacritics(_searchQuery.toLowerCase());
      return value.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/market_image_placeholder.jpg"),
                  Text(
                    widget.market.name!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Column(
                    children: [
                      Row(
                        spacing: 4,
                        children: [
                          Icon(Icons.house_outlined),
                          Text("Endereço do mercado"),
                        ],
                      ),
                      Row(
                        spacing: 4,
                        children: [
                          Icon(Icons.lock_clock),
                          Text(
                            "Fechado, abre novamente às 7:00",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Avaliações: Majoritariamente positivas",
                        style: TextStyle(
                          color: Color.fromARGB(255, 51, 117, 53),
                        ),
                      ),
                      Row(children: [Text("4.3/5"), Icon(Icons.star)]),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Navegue pelo estoque do mercado",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Material(
                    elevation: 5,
                    child: TextFormField(
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Pesquisar...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Mais escolhidos:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<dynamic>>(
              future: _searchFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(
                      child: Text(
                        "Ocorreu um erro inesperado ao carregar os produtos",
                      ),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(56),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: 0.5,
                          child: Image.asset(
                            "assets/images/girl/no_itens_in_bag.png",
                            width: 250,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Nenhum resultado encontrado.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 151, 151, 151),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final items = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SizedBox(
                    height: 240,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final product = items[index];
                        return ProductCard(product: product);
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
