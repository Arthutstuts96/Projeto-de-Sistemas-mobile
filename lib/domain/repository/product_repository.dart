import 'package:projeto_de_sistemas/domain/models/products/product.dart';

abstract class UserRepository {
    Future<List<Product>> getAllProducts();    
    Future<List<Product>> getProductsByCategory();    
    Future<Product> getProductById();    
}