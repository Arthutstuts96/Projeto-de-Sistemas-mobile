import 'dart:convert';

class Product {
  String name;
  String description;
  String category;
  String brand;
  double unityPrice;
  int quantity;
  DateTime expirationDate;
  int barCode;
  Product({
    required this.name,
    required this.description,
    required this.category,
    required this.brand,
    required this.unityPrice,
    required this.quantity,
    required this.expirationDate,
    required this.barCode,
  });

  Product copyWith({
    String? name,
    String? description,
    String? category,
    String? brand,
    double? unityPrice,
    int? quantity,
    DateTime? expirationDate,
    int? barCode,
  }) {
    return Product(
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      unityPrice: unityPrice ?? this.unityPrice,
      quantity: quantity ?? this.quantity,
      expirationDate: expirationDate ?? this.expirationDate,
      barCode: barCode ?? this.barCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'category': category,
      'brand': brand,
      'unityPrice': unityPrice,
      'quantity': quantity,
      'expirationDate': expirationDate.millisecondsSinceEpoch,
      'barCode': barCode,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      brand: map['brand'] as String,
      unityPrice: map['unityPrice'] as double,
      quantity: map['quantity'] as int,
      expirationDate: DateTime.fromMillisecondsSinceEpoch(map['expirationDate'] as int),
      barCode: map['barCode'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(name: $name, description: $description, category: $category, brand: $brand, unityPrice: $unityPrice, quantity: $quantity, expirationDate: $expirationDate, barCode: $barCode)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.description == description &&
      other.category == category &&
      other.brand == brand &&
      other.unityPrice == unityPrice &&
      other.quantity == quantity &&
      other.expirationDate == expirationDate &&
      other.barCode == barCode;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      description.hashCode ^
      category.hashCode ^
      brand.hashCode ^
      unityPrice.hashCode ^
      quantity.hashCode ^
      expirationDate.hashCode ^
      barCode.hashCode;
  }
}
