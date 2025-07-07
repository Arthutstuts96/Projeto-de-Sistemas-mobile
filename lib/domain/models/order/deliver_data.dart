// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DeliverData {
  int pedidoId;
  String tipoVeiculo;
  int enderecoId;
  
  DeliverData({
    required this.pedidoId,
    required this.tipoVeiculo,
    required this.enderecoId,
  });

  DeliverData copyWith({
    int? pedidoId,
    String? tipoVeiculo,
    int? enderecoId,
  }) {
    return DeliverData(
      pedidoId: pedidoId ?? this.pedidoId,
      tipoVeiculo: tipoVeiculo ?? this.tipoVeiculo,
      enderecoId: enderecoId ?? this.enderecoId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pedidoId': pedidoId,
      'tipoVeiculo': tipoVeiculo,
      'enderecoId': enderecoId,
    };
  }

  factory DeliverData.fromMap(Map<String, dynamic> map) {
    return DeliverData(
      pedidoId: map['pedidoId'] as int,
      tipoVeiculo: map['tipoVeiculo'] as String,
      enderecoId: map['enderecoId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliverData.fromJson(String source) => DeliverData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DeliverData(pedidoId: $pedidoId, tipoVeiculo: $tipoVeiculo, enderecoId: $enderecoId)';

  @override
  bool operator ==(covariant DeliverData other) {
    if (identical(this, other)) return true;
  
    return 
      other.pedidoId == pedidoId &&
      other.tipoVeiculo == tipoVeiculo &&
      other.enderecoId == enderecoId;
  }

  @override
  int get hashCode => pedidoId.hashCode ^ tipoVeiculo.hashCode ^ enderecoId.hashCode;
}
