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
}

class HomeProductsController with ChangeNotifier {
  final ProductControllerApi _productApi = ProductControllerApi();

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<CategoryModel> _categories = [];
  bool _isLoading = false;
  String? _error;
  bool _hasFetchedOnce = false;

  String? _selectedCategory;

  List<Product> get products => _filteredProducts;
  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasFetchedOnce => _hasFetchedOnce;
  String? get selectedCategory => _selectedCategory;

  HomeProductsController() {
    _initLoad();
  }

  Future<void> _initLoad() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _performFetchAndFilter(forceRefresh: true);
    } catch (e) {
      return;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _performFetchAndFilter({
    bool forceRefresh = false,
    String? category,
  }) async {
    if (_allProducts.isEmpty || forceRefresh || !_hasFetchedOnce) {
      final List<Product> fetchedProducts = await _productApi.fetchProducts();
      _allProducts = List.unmodifiable(fetchedProducts);
      _hasFetchedOnce = true;
      _error = null;

      _extractUniqueCategories();
    }

    _applyFilter(category ?? _selectedCategory);
  }

  Future<void> fetchProducts({
    bool forceRefresh = false,
    String? category,
  }) async {
    if (_isLoading && !forceRefresh) return;

    _isLoading = true;
    _error = null;

    try {
      await _performFetchAndFilter(
        forceRefresh: forceRefresh,
        category: category,
      );
    } catch (e) {
      _error = e.toString();
      _allProducts = [];
      _filteredProducts = [];
      _categories = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _extractUniqueCategories() {
    final Set<String> uniqueCategoryNamesFromProducts = {};
    for (var product in _allProducts) {
      if (product.category.isNotEmpty) {
        uniqueCategoryNamesFromProducts.add(product.category);
      }
    }

    List<CategoryModel> tempCategories = [];

    tempCategories.add(
      CategoryModel(id: 'all_products_category_id_unique', name: 'Todos'),
    );

    // Adiciona as categorias únicas extraídas dos produtos
    for (String name in uniqueCategoryNamesFromProducts) {
      if (name.toLowerCase() != 'todos') {
        tempCategories.add(CategoryModel(id: name.toLowerCase(), name: name));
      }
    }

    // Ordena a lista de categorias
    tempCategories.sort((a, b) {
      if (a.id == 'all_products_category_id_unique') {
        return -1;
      }
      if (b.id == 'all_products_category_id_unique') return 1;
      return a.name.compareTo(b.name);
    });

    _categories = List.unmodifiable(tempCategories);
  }

  void setSelectedCategory(String? category) {
    if (_selectedCategory == category &&
        _allProducts.isNotEmpty &&
        _filteredProducts.isNotEmpty &&
        !isLoading) {
      return;
    }

    _selectedCategory = category;
    _applyFilter(category);
    notifyListeners();
  }

  void _applyFilter(String? category) {
    if (category == null ||
        category == "Todos" ||
        category == "all" ||
        category == "all_products_category_id_unique") {
      _filteredProducts = List.from(_allProducts);
    } else {
      _filteredProducts =
          _allProducts.where((product) {
            return product.category.toLowerCase() == category.toLowerCase();
          }).toList();
    }
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
        return product.description;
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
    _isInitialLoading = true;
    notifyListeners();

    if (newSearchMode != null && _searchMode != newSearchMode) {
      _searchMode = newSearchMode;
      _searchQuery = "";
      if ((_searchMode == "item" && (!_productsFetched || forceRefreshData)) ||
          (_searchMode == "market" &&
              (!_marketsFetched || forceRefreshData))) {}
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

    if (_searchMode == "item" && !_productsFetched) {
      await _fetchInitialProducts();
    }
    if (_searchMode == "market" && !_marketsFetched) {
      await _fetchInitialMarkets();
    }

    _isInitialLoading = false;
    _applyFilters();
  }
}
