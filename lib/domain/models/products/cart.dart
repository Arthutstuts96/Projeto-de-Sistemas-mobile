import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';

class Cart {
  List<Product> cartItems;
  String orderNumber;
  int client;
  String paymentStatus;
  String orderStatus;
  double totalValue;

  Cart({
    required this.cartItems,
    required this.orderNumber,
    required this.client,
    required this.paymentStatus,
    required this.orderStatus,
    required this.totalValue,
  });

  Cart copyWith({
    List<Product>? cartItems,
    String? orderNumber,
    int? client,
    String? paymentStatus,
    String? orderStatus,
    double? totalValue,
  }) {
    return Cart(
      cartItems: cartItems ?? this.cartItems,
      orderNumber: orderNumber ?? this.orderNumber,
      client: client ?? this.client,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      orderStatus: orderStatus ?? this.orderStatus,
      totalValue: totalValue ?? this.totalValue,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cartItems': cartItems.map((x) => x.toMap()).toList(),
      'orderNumber': orderNumber,
      'client': client,
      'paymentStatus': paymentStatus,
      'orderStatus': orderStatus,
      'totalValue': totalValue,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      cartItems: List<Product>.from(
        (map['cartItems'] as List<dynamic>).map<Product>(
          (x) => Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
      orderNumber: map['orderNumber'] as String,
      client: map['client'] is int ? map['client'] : int.parse(map['client'].toString()),
      paymentStatus: map['paymentStatus'] as String,
      orderStatus: map['orderStatus'] as String,
      totalValue: (map['totalValue'] is int)
          ? (map['totalValue'] as int).toDouble()
          : map['totalValue'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) =>
      Cart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cart(cartItems: $cartItems, orderNumber: $orderNumber, client: $client, paymentStatus: $paymentStatus, orderStatus: $orderStatus, totalValue: $totalValue)';
  }

  @override
  bool operator ==(covariant Cart other) {
    if (identical(this, other)) return true;

    return listEquals(other.cartItems, cartItems) &&
        other.orderNumber == orderNumber &&
        other.client == client &&
        other.paymentStatus == paymentStatus &&
        other.orderStatus == orderStatus &&
        other.totalValue == totalValue;
  }

  @override
  int get hashCode {
    return cartItems.hashCode ^
        orderNumber.hashCode ^
        client.hashCode ^
        paymentStatus.hashCode ^
        orderStatus.hashCode ^
        totalValue.hashCode;
  }
}