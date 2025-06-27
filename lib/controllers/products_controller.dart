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
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;
  bool _hasFetchedOnce = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasFetchedOnce => _hasFetchedOnce;

  Future<void> fetchProducts({bool forceRefresh = false}) async {
    if (_hasFetchedOnce && _products.isNotEmpty && !forceRefresh) {
      // Dados já carregados e não é uma atualização forçada, não faz nada.
      return;
    }

    _isLoading = true;
    _error = null;
    if (forceRefresh) { // Se for refresh, notifica para mostrar o indicador de loading do RefreshIndicator
      notifyListeners();
    } else if (!_hasFetchedOnce) { // Só mostra loading na primeira vez
        notifyListeners();
    }


    try {
      _products = await ProductControllerApi().fetchProducts();
      _hasFetchedOnce = true;
    } catch (e) {
      _error = e.toString();
      _products = []; // Limpa produtos em caso de erro
    } finally {
      _isLoading = false;
      notifyListeners();
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
        return product.description; // Ajuste se 'brand' for outro campo
      case 'category':
        return product.category;
      case 'market':
        return product.market;
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
      _searchQuery = ""; // Reseta a busca ao mudar de modo
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
