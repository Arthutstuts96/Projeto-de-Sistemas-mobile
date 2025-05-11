import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';
import 'package:projeto_de_sistemas/screens/components/products/product_card.dart';
import 'package:projeto_de_sistemas/screens/components/register/button.dart';
import 'package:projeto_de_sistemas/utils/temp.dart';

class SearchProductsScreen extends StatefulWidget {
  SearchProductsScreen({super.key});

  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  List<Product> _filteredProducts = [];
  String _activeFilter = "name";

  @override
  void initState() {
    super.initState();
    _filteredProducts = mockProducts;
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts =
          mockProducts.where((product) {
            final value = _getProductPropertyValue(product, _activeFilter);
            return value.toLowerCase().contains(query.toLowerCase());
          }).toList();
    });
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

  // @override
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
          IconButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  String tempFilter = _activeFilter;
                  return StatefulBuilder(
                    builder: (
                      BuildContext context,
                      void Function(void Function()) setModalState,
                    ) {
                      return AlertDialog(
                        title: const Text('Escolha como filtrar:'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              ListTile(
                                title: const Text('Por nome'),
                                leading: Radio<String>(
                                  value: "name",
                                  groupValue: tempFilter,
                                  onChanged: (value) {
                                    setModalState(() {
                                      tempFilter = value!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('Por categoria'),
                                leading: Radio<String>(
                                  value: "category",
                                  groupValue: tempFilter,
                                  onChanged: (value) {
                                    setModalState(() {
                                      tempFilter = value!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('Por marca'),
                                leading: Radio<String>(
                                  value: "brand",
                                  groupValue: tempFilter,
                                  onChanged: (value) {
                                    setModalState(() {
                                      tempFilter = value!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('Por mercado'),
                                leading: Radio<String>(
                                  value: "market",
                                  groupValue: tempFilter,
                                  onChanged: (value) {
                                    setModalState(() {
                                      tempFilter = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          Button(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            text: "Cancelar",
                            color: Colors.deepOrange,
                          ),
                          Button(
                            onPressed: () {
                              setState(() {
                                _activeFilter = tempFilter;
                              });
                              Navigator.of(context).pop();
                            },
                            text: "Salvar",
                          ),
                        ],
                      );
                    },
                  );
                },
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
              onChanged: (value) {
                _filterProducts(value);
              },
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
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children:
                    _filteredProducts.map((product) {
                      return ProductCard(product: product);
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
