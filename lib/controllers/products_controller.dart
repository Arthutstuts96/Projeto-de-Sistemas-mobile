import '/domain/models/products/product.dart';

class ProductController {
  List<Product> getMockProducts() {
    return [
      Product(
        imagePath: 'assets/images/ovos.png',
        title: 'Caixa de ovos',
        price: 'R\$24,90',
        market: 'No supermercado Maior',
      ),
      Product(
        imagePath: 'assets/images/carne.png',
        title: 'Carne fresca',
        price: 'R\$39,90',
        market: 'No mercado da Vila',
      ),
    ];
  }
}
