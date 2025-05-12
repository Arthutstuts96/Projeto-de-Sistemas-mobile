import 'package:projeto_de_sistemas/domain/models/products/product.dart';
import 'package:projeto_de_sistemas/domain/repository/product_repository.dart';
import 'package:projeto_de_sistemas/services/api/products_home.dart';

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
