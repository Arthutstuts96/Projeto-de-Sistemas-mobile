import 'package:projeto_de_sistemas/domain/models/products/category_model.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';
import 'package:projeto_de_sistemas/domain/repository/product_repository.dart';
import 'package:projeto_de_sistemas/services/api/products_home_api.dart';
import 'package:flutter/foundation.dart';
import 'package:diacritic/diacritic.dart';
import 'package:projeto_de_sistemas/domain/models/users/market.dart';
import 'package:projeto_de_sistemas/controllers/market_controller.dart';

class ProductController implements ProductRepository {
  final ProductControllerApi _productApi = ProductControllerApi();

  @override
  Future<List<Product>> fetchProducts() async {
    return await _productApi.fetchProducts();
  }

  @override
  Future<List<Product>> getAllProducts() {
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById() {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProductsByCategory() {
    // TODO: implement getProductsByCategory
    throw UnimplementedError();
  }
}

class HomeProductsController with ChangeNotifier {
  final ProductControllerApi _productApi = ProductControllerApi();

  List<Product> _allProducts = []; // Lista completa de produtos
  List<Product> _filteredProducts =
      []; // Lista de produtos exibidos (com filtro)
  List<CategoryModel> _categories = []; // Lista de categorias extraídas
  bool _isLoading = false;
  String? _error;
  bool _hasFetchedOnce = false;

  String?
  _selectedCategory; // Armazena o nome da categoria selecionada para filtro

  // Getters para expor os dados para a UI
  List<Product> get products => _filteredProducts;
  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasFetchedOnce => _hasFetchedOnce;
  String? get selectedCategory => _selectedCategory;

  HomeProductsController() {
    _initLoad(); // Chamada inicial para buscar tudo de forma assíncrona
  }

  // Método de inicialização assíncrona para carregar dados iniciais
  Future<void> _initLoad() async {
    _isLoading = true;
    _error = null; // Limpa erros anteriores
    notifyListeners(); // Notifica para mostrar loading inicial na UI

    try {
      // Força a primeira busca de produtos e categorias
      await _performFetchAndFilter(forceRefresh: true);
    } catch (e) {
      // O erro já é tratado em _performFetchAndFilter, mas aqui para capturar erros fatais de inicialização.
      print("HomeProductsController: Erro fatal na inicialização: $e");
    } finally {
      _isLoading = false;
      notifyListeners(); // Notifica que a inicialização terminou (com ou sem dados)
    }
  }

  // Método privado para executar a lógica de busca e filtro
  Future<void> _performFetchAndFilter({
    bool forceRefresh = false,
    String? category,
  }) async {
    // APENAS busca da API se _allProducts está vazio OU se for forçar refresh
    if (_allProducts.isEmpty || forceRefresh || !_hasFetchedOnce) {
      final List<Product> fetchedProducts = await _productApi.fetchProducts();
      _allProducts = List.unmodifiable(
        fetchedProducts,
      ); // Torna a lista de todos os produtos imutável
      _hasFetchedOnce = true;
      _error = null;

      _extractUniqueCategories(); // Extrai categorias APÓS produtos serem carregados
    }

    // Aplica o filtro. Se uma 'category' foi passada, usa essa.
    // Senão, usa a _selectedCategory atual (se houver uma).
    _applyFilter(category ?? _selectedCategory);
  }

  /// Busca os produtos da API.
  /// [forceRefresh]: Se true, força a busca da API novamente.
  /// [category]: Se fornecido, filtra os produtos após a busca (ou na lista cacheada).
  Future<void> fetchProducts({
    bool forceRefresh = false,
    String? category,
  }) async {
    if (_isLoading && !forceRefresh) return;

    _isLoading = true;
    _error = null;
    // Remova notifyListeners() aqui! Será chamado no _initLoad ou no finally.
    // notifyListeners(); // Certifique-se de que ESTA LINHA está REMOVIDA para evitar race condition

    try {
      await _performFetchAndFilter(
        forceRefresh: forceRefresh,
        category: category,
      );
    } catch (e) {
      _error = e.toString();
      _allProducts = [];
      _filteredProducts = [];
      _categories = []; // Limpa categorias em caso de erro na busca de produtos
      print('HomeProductsController: Erro ao buscar/filtrar produtos: $_error');
    } finally {
      _isLoading = false;
      notifyListeners(); // Este é o notifyListeners() que deve estar AQUI
    }
  }

  // Extrai as categorias únicas da lista de _allProducts
  void _extractUniqueCategories() {
    final Set<String> uniqueCategoryNamesFromProducts = {};
    for (var product in _allProducts) {
      if (product.category != null && product.category.isNotEmpty) {
        uniqueCategoryNamesFromProducts.add(product.category);
      }
    }

    // Constrói a lista final de CategoryModel
    List<CategoryModel> tempCategories = [];

    // Adiciona a categoria "Todos" explicitamente no início com um ID único
    tempCategories.add(
      CategoryModel(id: 'all_products_category_id_unique', name: 'Todos'),
    );

    // Adiciona as categorias únicas extraídas dos produtos
    for (String name in uniqueCategoryNamesFromProducts) {
      if (name.toLowerCase() != 'todos') {
        // Evita adicionar "Todos" de novo se um produto já tiver essa categoria
        tempCategories.add(CategoryModel(id: name.toLowerCase(), name: name));
      }
    }

    // Ordena a lista de categorias
    tempCategories.sort((a, b) {
      if (a.id == 'all_products_category_id_unique')
        return -1; // "Todos" fica sempre primeiro
      if (b.id == 'all_products_category_id_unique') return 1;
      return a.name.compareTo(b.name);
    });

    _categories = List.unmodifiable(
      tempCategories,
    ); // Atribui e torna a lista imutável
    print(
      'HomeProductsController: Categorias extraídas (imutáveis): ${_categories.map((c) => c.name).toList()}, Length: ${_categories.length}',
    );
  }

  /// Define a categoria selecionada e aplica o filtro aos produtos.
  void setSelectedCategory(String? category) {
    // Apenas atualiza se a categoria for diferente
    // ou se a lista de produtos completa não foi carregada e precisa de filtro
    if (_selectedCategory == category &&
        _allProducts.isNotEmpty &&
        _filteredProducts.isNotEmpty &&
        !isLoading) {
      return;
    }

    _selectedCategory = category; // Atualiza a categoria selecionada
    _applyFilter(category); // Aplica o filtro na lista _allProducts
    notifyListeners(); // Notifica a UI para mostrar os produtos filtrados
    print('HomeProductsController: Categoria selecionada: $_selectedCategory');
  }

  // Aplica o filtro à lista _allProducts e atualiza _filteredProducts.
  void _applyFilter(String? category) {
    if (category == null ||
        category == "Todos" ||
        category == "all" ||
        category == "all_products_category_id_unique") {
      _filteredProducts = List.from(
        _allProducts,
      ); // Retorna uma cópia da lista completa
    } else {
      _filteredProducts =
          _allProducts.where((product) {
            // Garante que product.category não é nulo antes de comparar
            return product.category?.toLowerCase() ==
                category.toLowerCase(); // Use '?' se category é nullable
          }).toList();
    }
    print(
      'HomeProductsController: Produtos filtrados: ${_filteredProducts.length} itens.',
    );
  }
}
class SearchScreenController with ChangeNotifier {
  List<Product> _allProducts = [];
  List<Market> _allMarkets = [];
  List<dynamic> _filteredItems = [];

  bool _isInitialLoading = false;
  String? _error;
  bool _productsFetched = false;
  bool _marketsFetched = false;

  String _searchQuery = "";
  String _activeProductFilter = "name";
  String _searchMode = "item";

  List<dynamic> get filteredItems => _filteredItems;
  bool get isLoading =>
      _isInitialLoading &&
      _filteredItems
          .isEmpty; // Mostra loading se estiver carregando e não há nada para mostrar
  String? get error => _error;
  String get searchQuery => _searchQuery;
  String get activeProductFilter => _activeProductFilter;
  String get searchMode => _searchMode;

  Future<void> _fetchInitialProducts({bool force = false}) async {
    if (_productsFetched && !force) return;
    _isInitialLoading = true;
    notifyListeners();
    try {
      // Usando ProductControllerApi como na HomeScreen, ajuste se for diferente
      _allProducts = await ProductControllerApi().fetchProducts();
      _productsFetched = true;
      _error = null;
    } catch (e) {
      _error = "Erro ao carregar produtos: ${e.toString()}";
      _allProducts = [];
    }
    _isInitialLoading = false;
  }

  Future<void> _fetchInitialMarkets({bool force = false}) async {
    if (_marketsFetched && !force) return;
    _isInitialLoading = true;
    notifyListeners();
    try {
      _allMarkets = await MarketController().getAllMarkets();
      _marketsFetched = true;
      _error = null;
    } catch (e) {
      _error = "Erro ao carregar mercados: ${e.toString()}";
      _allMarkets = [];
    }
    _isInitialLoading = false;
  }

  Future<void> initialLoad() async {
    bool needsFilter = false;
    if (_searchMode == "item" && !_productsFetched) {
      await _fetchInitialProducts();
      needsFilter = true;
    } else if (_searchMode == "market" && !_marketsFetched) {
      await _fetchInitialMarkets();
      needsFilter = true;
    }

    if (needsFilter ||
        _filteredItems.isEmpty && (_productsFetched || _marketsFetched)) {
      _applyFilters();
    } else {
      notifyListeners(); // Para atualizar a UI se já tinha dados
    }
  }

  void _applyFilters() {
    if (_searchMode == "item") {
      if (!_productsFetched) {
        _filteredItems = [];
      } else {
        _filteredItems =
            _allProducts.where((product) {
              final value = removeDiacritics(
                _getProductPropertyValue(
                  product,
                  _activeProductFilter,
                ).toLowerCase(),
              );
              final query = removeDiacritics(_searchQuery.toLowerCase());
              return value.contains(query);
            }).toList();
      }
    } else {
      if (!_marketsFetched) {
        _filteredItems = [];
      } else {
        _filteredItems =
            _allMarkets.where((market) {
              final marketName = market.name ?? ""; // Tratar nome nulo
              return removeDiacritics(
                marketName.toLowerCase(),
              ).contains(removeDiacritics(_searchQuery.toLowerCase()));
            }).toList();
      }
    }
    notifyListeners();
  }

  String _getProductPropertyValue(Product product, String property) {
    switch (property) {
      case 'name':
        return product.name;
      case 'brand':
        return product.description; // Ajuste se 'brand' for outro campo
      case 'category':
        return product.category;
      default:
        return '';
    }
  }

  Future<void> updateSearchParameters({
    String? newQuery,
    String? newProductFilter,
    String? newSearchMode,
    bool forceRefreshData = false,
  }) async {
    _isInitialLoading =
        true; // Mostrar loading durante o refresh dos dados base
    notifyListeners();

    if (newSearchMode != null && _searchMode != newSearchMode) {
      _searchMode = newSearchMode;
      _searchQuery = ""; // Reseta a busca ao mudar de modor
      // Força a busca inicial do novo modo se ainda não foi feita ou se forceRefreshData
      if ((_searchMode == "item" && (!_productsFetched || forceRefreshData)) ||
          (_searchMode == "market" && (!_marketsFetched || forceRefreshData))) {
        // Não precisamos de await aqui, pois o initialLoad fará notifyListeners
      }
    }
    if (newQuery != null) {
      _searchQuery = newQuery;
    }
    if (newProductFilter != null) {
      _activeProductFilter = newProductFilter;
    }

    if (forceRefreshData) {
      if (_searchMode == "item") {
        await _fetchInitialProducts(force: true);
      } else {
        await _fetchInitialMarkets(force: true);
      }
    }

    // Garante que os dados base para o modo atual estejam carregados antes de filtrar
    if (_searchMode == "item" && !_productsFetched)
      await _fetchInitialProducts();
    if (_searchMode == "market" && !_marketsFetched)
      await _fetchInitialMarkets();

    _isInitialLoading = false; // Terminou o loading dos dados base
    _applyFilters(); // Aplica filtros com os dados atualizados ou novos parâmetros
  }
}