// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  int id;
  String name;
  String description;
  double unityPrice;
  String category;
  String brand;
  String market;
  int quantity;
  String barCode;
  int reviews;
  double rating;
  String imageUrl;
  int quantityToBuy;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.unityPrice,
    required this.category,
    required this.brand,
    this.market = "",
    required this.quantity,
    required this.barCode,
    required this.reviews,
    required this.rating,
    required this.imageUrl,
    this.quantityToBuy = 1,
  });

  Product copyWith({
    int? id,
    String? name,
    String? description,
    double? unitPrice,
    String? category,
    String? brand,
    String? market,
    int? stockQuantity,
    String? barCode,
    int? reviews,
    double? rating,
    String? imageUrl,
    int? quantityToBuy,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      unityPrice: unitPrice ?? this.unityPrice,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      market: market ?? this.market,
      quantity: stockQuantity ?? this.quantity,
      barCode: barCode ?? this.barCode,
      reviews: reviews ?? this.reviews,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      quantityToBuy: quantityToBuy ?? this.quantityToBuy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'unitPrice': unityPrice,
      'category': category,
      'brand': brand,
      'market': market,
      'stockQuantity': quantity,
      'barCode': barCode,
      'reviews': reviews,
      'rating': rating,
      'imageUrl': imageUrl,
      'quantityToBuy': quantityToBuy,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      unityPrice: map['unitPrice'] as double,
      category: map['category'] as String,
      brand: map['brand'] as String,
      market: map['market'] ?? '',
      quantity: map['stockQuantity'] as int,
      barCode: map['barCode'] as String,
      reviews: map['reviews'] as int,
      rating: map['rating'] as double,
      imageUrl: map['imageUrl'] as String,
      quantityToBuy:
          map['quantityToBuy'] is int ? map['quantityToBuy'] as int : 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['nome'] ?? '',
      description: json['descricao'] ?? '',
      unityPrice:
          double.tryParse(json['preco_unitario']?.toString() ?? '0.0') ?? 0.0,
      category: json['categoria']?.toString() ?? '',
      brand: json['marca'] ?? '',
      market: json['market'] ?? '',
      quantity: json['qtd_estoque'] ?? 0,
      barCode: json['codigo_barras'] ?? '',
      reviews: json['qtd_avaliacoes'] ?? 0,
      rating: double.tryParse(json['avaliacao']?.toString() ?? '0.0') ?? 0.0,
      imageUrl: json['imagem'] ?? '',
      quantityToBuy: json['quantityToBuy'] ?? 1,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, unitPrice: $unityPrice, category: $category, brand: $brand, market: $market, stockQuantity: $quantity, barCode: $barCode, reviews: $reviews, rating: $rating, imageUrl: $imageUrl, quantityToBuy: $quantityToBuy)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.unityPrice == unityPrice &&
        other.category == category &&
        other.brand == brand &&
        other.market == market &&
        other.quantity == quantity &&
        other.barCode == barCode &&
        other.reviews == reviews &&
        other.rating == rating &&
        other.imageUrl == imageUrl &&
        other.quantityToBuy == quantityToBuy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        unityPrice.hashCode ^
        category.hashCode ^
        brand.hashCode ^
        market.hashCode ^
        quantity.hashCode ^
        barCode.hashCode ^
        reviews.hashCode ^
        rating.hashCode ^
        imageUrl.hashCode ^
        quantityToBuy.hashCode;
  }
}
