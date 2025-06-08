import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'order_item.dart';
import 'deliver_data.dart';

class Order {
  String? enderecoEntrega;

  final double? mercadoLatitude;
  final double? mercadoLongitude;
  final double? clientLatitude;
  final double? clientLongitude;

  String numeroPedido;
  int? usuario;
  String statusPagamento;
  String statusPedido;
  double valorTotal;
  String? descricao;
  DateTime? dataPagamento;
  DateTime criadoEm;
  List<DeliverData>? dadosEntrega;
  List<OrderItem> itens;

  Order({
    this.enderecoEntrega,
    required this.numeroPedido,
    this.usuario,
    required this.statusPagamento,
    required this.statusPedido,
    required this.valorTotal,
    this.descricao,
    this.dataPagamento,
    required this.criadoEm,
    required this.itens,
    required this.dadosEntrega,

    this.mercadoLatitude = -10.178542485637115,
    this.mercadoLongitude = -48.33290926223811,
    this.clientLatitude = -10.232807,
    this.clientLongitude = -48.322240,
  });

  Order copyWith({
    String? enderecoEntrega,
    String? numeroPedido,
    int? usuario,
    String? statusPagamento,
    String? statusPedido,
    double? valorTotal,
    String? descricao,
    DateTime? dataPagamento,
    DateTime? criadoEm,
    List<OrderItem>? itens,
    List<DeliverData>? dadosEntrega,
    double? mercadoLatitude,
    double? mercadoLongitude,
    double? clientLatitude,
    double? clientLongitude,
  }) {
    return Order(
      enderecoEntrega: enderecoEntrega ?? this.enderecoEntrega,
      numeroPedido: numeroPedido ?? this.numeroPedido,
      usuario: usuario ?? this.usuario,
      statusPagamento: statusPagamento ?? this.statusPagamento,
      statusPedido: statusPedido ?? this.statusPedido,
      valorTotal: valorTotal ?? this.valorTotal,
      descricao: descricao ?? this.descricao,
      dataPagamento: dataPagamento ?? this.dataPagamento,
      criadoEm: criadoEm ?? this.criadoEm,
      itens: itens ?? this.itens,
      dadosEntrega: dadosEntrega ?? this.dadosEntrega,
      mercadoLatitude: mercadoLatitude ?? this.mercadoLatitude,
      mercadoLongitude: mercadoLongitude ?? this.mercadoLongitude,
      clientLatitude: clientLatitude ?? this.clientLatitude,
      clientLongitude: clientLongitude ?? this.clientLongitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enderecoEntrega': enderecoEntrega,
      'numeroPedido': numeroPedido,
      'usuario': usuario,
      'statusPagamento': statusPagamento,
      'statusPedido': statusPedido,
      'valorTotal': valorTotal,
      'descricao': descricao,
      'dataPagamento': dataPagamento?.toIso8601String(),
      'criadoEm': criadoEm.toIso8601String(),
      'itens': itens.map((x) => x.toMap()).toList(),
      'dadosEntrega': dadosEntrega?.map((x) => x.toMap()).toList(),
      'mercadoLatitude': mercadoLatitude,
      'mercadoLongitude': mercadoLongitude,
      'clientLatitude': clientLatitude,
      'clientLongitude': clientLongitude,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {

    // Valores padrão para as coordenadas do mercado e do cliente
    const double defaultMercadoLat = -10.178542485637115;
    const double defaultMercadoLon = -48.33290926223811;
    const double defaultClientLat = -10.232807;
    const double defaultClientLon = -48.322240;

    return Order(
      enderecoEntrega: map['enderecoEntrega'] as String?,
      numeroPedido: map['numeroPedido'] as String,
      usuario: map['usuario'],
      statusPagamento: map['statusPagamento'] as String,
      statusPedido: map['statusPedido'] as String,
      valorTotal:
          map['valorTotal'] is int
              ? (map['valorTotal'] as int).toDouble()
              : map['valorTotal'] as double,
      descricao: map['descricao'],
      dataPagamento:
          map['dataPagamento'] != null
              ? DateTime.parse(map['dataPagamento'])
              : null,
      criadoEm: DateTime.parse(map['criadoEm']),
      itens: List<OrderItem>.from(
        (map['itens'] as List).map((x) => OrderItem.fromMap(x)),
      ),
      dadosEntrega:
          map['dadosEntrega'] != null
              ? List<DeliverData>.from(
                (map['dadosEntrega'] as List).map(
                  (x) => DeliverData.fromMap(x),
                ),
              )
              : null,
      mercadoLatitude: map['mercadoLatitude'] as double? ?? defaultMercadoLat,
      mercadoLongitude: map['mercadoLongitude'] as double? ?? defaultMercadoLon,
      clientLatitude: map['clientLatitude'] as double? ?? defaultClientLat,
      clientLongitude: map['clientLongitude'] as double? ?? defaultClientLon,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(enderecoEntrega: $enderecoEntrega ,numeroPedido: $numeroPedido, usuario: $usuario, statusPagamento: $statusPagamento, statusPedido: $statusPedido, valorTotal: $valorTotal, descricao: $descricao, dataPagamento: $dataPagamento, criadoEm: $criadoEm, itens: $itens, dadosEntrega: $dadosEntrega, mercadoLatitude: $mercadoLatitude, mercadoLongitude: $mercadoLongitude, clientLatitude: $clientLatitude, clientLongitude: $clientLongitude)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.enderecoEntrega == enderecoEntrega &&
        other.numeroPedido == numeroPedido &&
        other.usuario == usuario &&
        other.statusPagamento == statusPagamento &&
        other.statusPedido == statusPedido &&
        other.valorTotal == valorTotal &&
        other.descricao == descricao &&
        other.dataPagamento == dataPagamento &&
        other.criadoEm == criadoEm &&
        listEquals(other.itens, itens) &&
        listEquals(other.dadosEntrega, dadosEntrega) &&
        other.mercadoLatitude == mercadoLatitude &&
        other.mercadoLongitude == mercadoLongitude &&
        other.clientLatitude == clientLatitude &&
        other.clientLongitude == clientLongitude;
  }

  @override
  int get hashCode {
    return numeroPedido.hashCode ^
        enderecoEntrega.hashCode ^
        usuario.hashCode ^
        statusPagamento.hashCode ^
        statusPedido.hashCode ^
        valorTotal.hashCode ^
        descricao.hashCode ^
        dataPagamento.hashCode ^
        criadoEm.hashCode ^
        itens.hashCode ^
        dadosEntrega.hashCode ^
        mercadoLatitude.hashCode ^
        mercadoLongitude.hashCode ^
        clientLatitude.hashCode ^
        clientLongitude.hashCode;
  }
}
