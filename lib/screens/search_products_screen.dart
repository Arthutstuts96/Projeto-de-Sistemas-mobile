import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_de_sistemas/controllers/products_controller.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';
import 'package:projeto_de_sistemas/domain/models/users/market.dart';
import 'package:projeto_de_sistemas/screens/components/products/product_card.dart';
import 'package:projeto_de_sistemas/screens/components/market/card_market.dart';

class SearchProductsScreen extends StatefulWidget {
  const SearchProductsScreen({super.key});

  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  // Os estados locais para _activeFilter, _searchQuery e _searchMode
  // serão agora gerenciados ou sincronizados com o SearchScreenController.
  // Para a UI, podemos manter cópias locais que são atualizadas
  // ou ler diretamente do controller. Vamos ler do controller.
  // O controller será a fonte da verdade.

  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Provider.of<SearchScreenController>(
        context,
        listen: false,
      );
      _searchTextController.text =
          controller.searchQuery; // Sincroniza o campo de texto
      controller.initialLoad();
    });
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh(BuildContext context) async {
    final controller = Provider.of<SearchScreenController>(
      context,
      listen: false,
    );
    // Ao puxar para atualizar, força o refresh dos dados base do modo atual
    // e reaplica os filtros/query atuais.
    await controller.updateSearchParameters(forceRefreshData: true);
  }

  void _onSearchChanged(BuildContext context, String query) {
    Provider.of<SearchScreenController>(
      context,
      listen: false,
    ).updateSearchParameters(newQuery: query);
  }

  void _onModeChanged(BuildContext context, String mode) {
    _searchTextController.clear(); // Limpa o texto da busca ao mudar de modo
    Provider.of<SearchScreenController>(
      context,
      listen: false,
    ).updateSearchParameters(newSearchMode: mode, newQuery: ""); // Reseta query
  }

  void _applyProductFilter(BuildContext context, String newFilter) {
    Provider.of<SearchScreenController>(
      context,
      listen: false,
    ).updateSearchParameters(newProductFilter: newFilter);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchScreenController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFFFAA00),
            title: const Text(
              "Procurar por item/mercado",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 24,
              ),
            ),
            actions: [
              if (controller.searchMode == "item")
                IconButton(
                  icon: const Icon(
                    Icons.filter_alt_outlined,
                    size: 35,
                    color: Colors.black,
                  ),
                  onPressed:
                      () => _showFilterDialog(
                        context,
                        controller.activeProductFilter,
                      ),
                ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: TextFormField(
                  controller: _searchTextController,
                  onChanged: (query) => _onSearchChanged(context, query),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Pesquisar...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon:
                        controller.searchQuery.isNotEmpty
                            ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchTextController.clear();
                                _onSearchChanged(context, "");
                              },
                            )
                            : null,
                  ),
                ),
              ),
            ),
          ),
          body: Column(
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
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => _onModeChanged(context, "item"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                controller.searchMode == "item"
                                    ? Colors.orange
                                    : Colors.white,
                          ),
                          child: Text(
                            "Item",
                            style: TextStyle(
                              color:
                                  controller.searchMode == "item"
                                      ? Colors.white
                                      : const Color(0xFFFFAA00),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => _onModeChanged(context, "market"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                controller.searchMode == "market"
                                    ? Colors.orange
                                    : Colors.white,
                          ),
                          child: Text(
                            "Mercado",
                            style: TextStyle(
                              color:
                                  controller.searchMode == "market"
                                      ? Colors.white
                                      : const Color(0xFFFFAA00),
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
                  onRefresh: () => _handleRefresh(context),
                  child: _buildResultsList(controller),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildResultsList(SearchScreenController controller) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (controller.error != null) {
      return Center(child: Text("Não foi possível buscar os produtos"));
    } else if (controller.filteredItems.isEmpty) {
      return LayoutBuilder(
        // Para o SingleChildScrollView dentro do RefreshIndicator funcionar
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
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
              ),
            ),
          );
        },
      );
    }

    final items = controller.filteredItems;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.count(
        crossAxisCount: controller.searchMode == "market" ? 1 : 2,
        childAspectRatio: controller.searchMode == "market" ? 1.2 : 0.72,
        shrinkWrap: false,
        physics: const AlwaysScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: const EdgeInsets.only(bottom: 16),
        children:
            items.map((item) {
              if (controller.searchMode == "item" && item is Product) {
                return ProductCard(product: item);
              } else if (controller.searchMode == "market" && item is Market) {
                return CardMarket(market: item);
              } else {
                return const SizedBox.shrink();
              }
            }).toList(),
      ),
    );
  }

  void _showFilterDialog(BuildContext context, String currentFilter) {
    String tempFilter = currentFilter;
    showDialog(
      context: context,
      builder: (dialogContext) {
        // Renomeado para evitar conflito com context da tela
        return StatefulBuilder(
          // Necessário para o Radio atualizar dentro do Dialog
          builder: (context, setModalState) {
            // setModalState é do StatefulBuilder
            return AlertDialog(
              title: const Text('Escolha como filtrar:'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildRadioOption(
                    "Por nome",
                    "name",
                    tempFilter,
                    (newValue) => setModalState(() => tempFilter = newValue),
                  ),
                  _buildRadioOption(
                    "Por categoria",
                    "category",
                    tempFilter,
                    (newValue) => setModalState(() => tempFilter = newValue),
                  ),
                  _buildRadioOption(
                    "Por marca",
                    "brand",
                    tempFilter,
                    (newValue) => setModalState(() => tempFilter = newValue),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text("Cancelar"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _applyProductFilter(
                      context,
                      tempFilter,
                    ); // Usa o context da tela
                    Navigator.pop(dialogContext);
                  },
                  child: const Text("Salvar"),
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
    ValueChanged<String> onChanged,
  ) {
    return ListTile(
      title: Text(label),
      leading: Radio<String>(
        value: value,
        groupValue: groupValue,
        onChanged: (newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
      ),
      onTap: () {
        // Para permitir clicar na linha toda
        if (value != groupValue) {
          onChanged(value);
        }
      },
    );
  }
}
