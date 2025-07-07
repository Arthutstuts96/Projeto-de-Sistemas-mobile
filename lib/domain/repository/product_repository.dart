import 'package:projeto_de_sistemas/domain/models/products/product.dart';

abstract class ProductRepository {   
    Future<List<Product>> fetchProducts();
}