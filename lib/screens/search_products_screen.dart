import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/market_controller.dart';
import 'package:projeto_de_sistemas/controllers/products_controller.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';
import 'package:projeto_de_sistemas/domain/models/market.dart';
import 'package:projeto_de_sistemas/screens/components/products/product_card.dart';
import 'package:projeto_de_sistemas/screens/components/market/card_market.dart';

class SearchProductsScreen extends StatefulWidget {
  const SearchProductsScreen({super.key});

  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  String _activeFilter = "name";
  String _searchQuery = "";
  String _searchMode = "item"; // "item" ou "market"
  late Future<List<dynamic>> _searchFuture;

  @override
  void initState() {
    super.initState();
    _searchFuture = _fetchData();
  }

  Future<List<dynamic>> _fetchData() async {
    if (_searchMode == "item") {
      final products = await ProductController().fetchProducts();
      return _filterProductList(products);
    } else {
      final markets = await MarketController().getAllMarkets();
      return _filterMarketList(markets);
    }
  }

  List<Product> _filterProductList(List<Product> list) {
    return list.where((product) {
      final value = removeDiacritics(
        _getProductPropertyValue(product, _activeFilter).toLowerCase(),
      );
      final query = removeDiacritics(_searchQuery.toLowerCase());
      return value.contains(query);
    }).toList();
  }

  List<Market> _filterMarketList(List<Market> list) {
    return list.where((market) {
      return market.name!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  String _getProductPropertyValue(Product product, String property) {
    switch (property) {
      case 'name':
        return product.name;
      case 'brand':
        return product.description;
      case 'category':
        return product.category;
      case 'market':
        return product.market;
      default:
        return '';
    }
  }

  void _refreshData() {
    setState(() {
      _searchFuture = _fetchData();
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _searchFuture = _fetchData();
    });
  }

  void _onModeChanged(String mode) {
    setState(() {
      _searchMode = mode;
      _searchQuery = "";
      _searchFuture = _fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFAA00),
        title: Text(
          "Procurar por item/mercado",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        actions: [
          if (_searchMode == "item")
            IconButton(
              icon: Icon(
                Icons.filter_alt_outlined,
                size: 35,
                color: Colors.black,
              ),
              onPressed: () => _showFilterDialog(),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Resultados",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _onModeChanged("item"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _searchMode == "item"
                                ? Colors.orange
                                : const Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Text(
                        "Item",
                        style: TextStyle(
                          color:
                              _searchMode == "item"
                                  ? Colors.white
                                  : Color(0xFFFFAA00),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _onModeChanged("market"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _searchMode == "market"
                                ? Colors.orange
                                : const Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Text(
                        "Mercado",
                        style: TextStyle(
                          color:
                              _searchMode == "market"
                                  ? Colors.white
                                  : Color(0xFFFFAA00),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => _refreshData(),
              child: FutureBuilder<List<dynamic>>(
                future: _searchFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Erro ao carregar dados."));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(56),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Opacity(
                            opacity: 0.5,
                            child: Image.asset(
                              "assets/images/no_itens_in_bag.png",
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
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GridView.count(
                      crossAxisCount: _searchMode == "market" ? 1 : 2,
                      childAspectRatio: _searchMode == "market" ? 1 : 0.72,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children:
                          items.map((item) {
                            if (_searchMode == "item" && item is Product) {
                              return ProductCard(product: item);
                            } else if (_searchMode == "market" &&
                                item is Market) {
                              return CardMarket(market: item);
                            } else {
                              return SizedBox.shrink();
                            }
                          }).toList(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    String tempFilter = _activeFilter;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              title: const Text('Escolha como filtrar:'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildRadioOption(
                    "Por nome",
                    "name",
                    tempFilter,
                    setModalState,
                  ),
                  _buildRadioOption(
                    "Por categoria",
                    "category",
                    tempFilter,
                    setModalState,
                  ),
                  _buildRadioOption(
                    "Por marca",
                    "brand",
                    tempFilter,
                    setModalState,
                  ),
                  _buildRadioOption(
                    "Por mercado",
                    "market",
                    tempFilter,
                    setModalState,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _activeFilter = tempFilter;
                      _searchFuture = _fetchData();
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Salvar"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildRadioOption(
    String label,
    String value,
    String groupValue,
    void Function(void Function()) setModalState,
  ) {
    return ListTile(
      title: Text(label),
      leading: Radio<String>(
        value: value,
        groupValue: groupValue,
        onChanged: (newValue) {
          setModalState(() {
            groupValue = newValue!;
          });
        },
      ),
    );
  }
}
