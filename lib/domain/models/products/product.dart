import 'dart:convert';

class Product {
  int id;
  String name;
  String description;
  String category;
  String brand;
  String market;
  double unityPrice;
  int quantity;
  DateTime expirationDate;
  String image;
  int barCode;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.brand,
    required this.market,
    required this.unityPrice,
    required this.quantity,
    required this.expirationDate,
    required this.image,
    required this.barCode,
  });
  

  Product copyWith({
    int? id,
    String? name,
    String? description,
    String? category,
    String? brand,
    String? market,
    double? unityPrice,
    int? quantity,
    DateTime? expirationDate,
    String? image,
    int? barCode,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      market: market ?? this.market,
      unityPrice: unityPrice ?? this.unityPrice,
      quantity: quantity ?? this.quantity,
      expirationDate: expirationDate ?? this.expirationDate,
      image: image ?? this.image,
      barCode: barCode ?? this.barCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'brand': brand,
      'market': market,
      'unityPrice': unityPrice,
      'quantity': quantity,
      'expirationDate': expirationDate.millisecondsSinceEpoch,
      'image': image,
      'barCode': barCode,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      brand: map['brand'] as String,
      market: map['market'] as String,
      unityPrice: map['unityPrice'] as double,
      quantity: map['quantity'] as int,
      expirationDate: DateTime.fromMillisecondsSinceEpoch(map['expirationDate'] as int),
      image: map['image'] as String,
      barCode: map['barCode'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, category: $category, brand: $brand, market: $market, unityPrice: $unityPrice, quantity: $quantity, expirationDate: $expirationDate, image: $image, barCode: $barCode)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.category == category &&
      other.brand == brand &&
      other.market == market &&
      other.unityPrice == unityPrice &&
      other.quantity == quantity &&
      other.expirationDate == expirationDate &&
      other.image == image &&
      other.barCode == barCode;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      category.hashCode ^
      brand.hashCode ^
      market.hashCode ^
      unityPrice.hashCode ^
      quantity.hashCode ^
      expirationDate.hashCode ^
      image.hashCode ^
      barCode.hashCode;
  }
}
