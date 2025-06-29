// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  int id;
  String name;
  String description;
  double unityPrice;
  String category;
  String brand;
  int quantity;
  String barCode;
  int reviews;
  double rating;
  String imageUrl;
  int quantityToBuy;
  int? supermarketId;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.unityPrice,
    required this.category,
    required this.brand,
    required this.quantity,
    required this.barCode,
    required this.reviews,
    required this.rating,
    required this.imageUrl,
    required this.quantityToBuy,
    this.supermarketId,
  });

  Product copyWith({
    int? id,
    String? name,
    String? description,
    double? unityPrice,
    String? category,
    String? brand,
    int? quantity,
    String? barCode,
    int? reviews,
    double? rating,
    String? imageUrl,
    int? quantityToBuy,
    int? supermarketId,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      unityPrice: unityPrice ?? this.unityPrice,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      quantity: quantity ?? this.quantity,
      barCode: barCode ?? this.barCode,
      reviews: reviews ?? this.reviews,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      quantityToBuy: quantityToBuy ?? this.quantityToBuy,
      supermarketId: supermarketId ?? this.supermarketId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'unityPrice': unityPrice,
      'category': category,
      'brand': brand,
      'quantity': quantity,
      'barCode': barCode,
      'reviews': reviews,
      'rating': rating,
      'imageUrl': imageUrl,
      'quantityToBuy': quantityToBuy,
      'supermarketId': supermarketId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      unityPrice: map['unityPrice'] as double,
      category: map['category'] as String,
      brand: map['brand'] as String,
      quantity: map['quantity'] as int,
      barCode: map['barCode'] as String,
      reviews: map['reviews'] as int,
      rating: map['rating'] as double,
      imageUrl: map['imageUrl'] as String,
      quantityToBuy:
          map['quantityToBuy'] is int ? map['quantityToBuy'] as int : 1,
      supermarketId: map['supermarketId'] ?? 0
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
      quantity: json['qtd_estoque'] ?? 0,
      barCode: json['codigo_barras'] ?? '',
      reviews: json['qtd_avaliacoes'] ?? 0,
      rating: double.tryParse(json['avaliacao']?.toString() ?? '0.0') ?? 0.0,
      imageUrl: json['imagem'] ?? '',
      quantityToBuy: json['quantityToBuy'] ?? 1,
      supermarketId: json['supermarketId'] ?? 0
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, unityPrice: $unityPrice, category: $category, brand: $brand, quantity: $quantity, barCode: $barCode, reviews: $reviews, rating: $rating, imageUrl: $imageUrl, quantityToBuy: $quantityToBuy, supermarketId: $supermarketId)';
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
        other.quantity == quantity &&
        other.barCode == barCode &&
        other.reviews == reviews &&
        other.rating == rating &&
        other.imageUrl == imageUrl &&
        other.quantityToBuy == quantityToBuy &&
        other.supermarketId == supermarketId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        unityPrice.hashCode ^
        category.hashCode ^
        brand.hashCode ^
        quantity.hashCode ^
        barCode.hashCode ^
        reviews.hashCode ^
        rating.hashCode ^
        imageUrl.hashCode ^
        quantityToBuy.hashCode ^
        supermarketId.hashCode;
  }
}
