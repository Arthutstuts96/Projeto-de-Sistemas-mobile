import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'order_item.dart';
import 'deliver_data.dart';

class Order {
  String? enderecoEntrega;
  String numeroPedido;
  int? usuario;
  String statusPagamento;
  String statusPedido;
  double valorTotal;
  String? descricao;
  DateTime? dataPagamento;
  DateTime criadoEm;
  DeliverData? dadosEntrega;
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
    DeliverData? dadosEntrega,
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
      'dadosEntrega': dadosEntrega,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
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
      dadosEntrega: map['dadosEntrega'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(enderecoEntrega: $enderecoEntrega ,numeroPedido: $numeroPedido, usuario: $usuario, statusPagamento: $statusPagamento, statusPedido: $statusPedido, valorTotal: $valorTotal, descricao: $descricao, dataPagamento: $dataPagamento, criadoEm: $criadoEm, itens: $itens, dadosEntrega: $dadosEntrega)';
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
        other.dadosEntrega == dadosEntrega;
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
        dadosEntrega.hashCode;
  }
}
