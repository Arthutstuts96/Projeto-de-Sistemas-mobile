class Product {
  final String imagePath;
  final String name;
  final String price;
  final String market;

  Product({
    required this.imagePath,
    required this.name,
    required this.price,
    required this.market,
  });
  
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      imagePath: json['imagePath'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      market: json['market'] ?? '',
    );
  }
}
