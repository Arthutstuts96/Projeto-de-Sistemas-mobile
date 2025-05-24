import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';

class Cart {
  List<Product> cartItems;
  String orderNumber;
  double itensPrice;
  int client;

  Cart({
    required this.cartItems,
    required this.orderNumber,
    required this.itensPrice,
    required this.client,
  });

  Cart copyWith({
    List<Product>? cartItems,
    String? orderNumber,
    double? itensPrice,
    int? client,
  }) {
    return Cart(
      cartItems: cartItems ?? this.cartItems,
      orderNumber: orderNumber ?? this.orderNumber,
      itensPrice: itensPrice ?? this.itensPrice,
      client: client ?? this.client,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cartItems': cartItems.map((x) => x.toMap()).toList(),
      'orderNumber': orderNumber,
      'itensPrice': itensPrice,
      'client': client,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      cartItems: List<Product>.from(
        (map['cartItems'] as List).map<Product>(
          (x) => Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
      orderNumber: map['orderNumber'] as String,
      itensPrice:
          map['itensPrice'] == null
              ? 0.0
              : map['itensPrice'] is int
              ? (map['itensPrice'] as int).toDouble()
              : map['itensPrice'] as double,

      client: map['client'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) =>
      Cart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cart(cartItems: $cartItems, orderNumber: $orderNumber, itensPrice: $itensPrice, client: $client)';
  }

  @override
  bool operator ==(covariant Cart other) {
    if (identical(this, other)) return true;

    return listEquals(other.cartItems, cartItems) &&
        other.orderNumber == orderNumber &&
        other.itensPrice == itensPrice &&
        other.client == client;
  }

  @override
  int get hashCode {
    return cartItems.hashCode ^
        orderNumber.hashCode ^
        itensPrice.hashCode ^
        client.hashCode;
  }
}
