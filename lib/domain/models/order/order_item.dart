// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderItem {
  int? produtoId;
  int quantidade;
  double precoUnitario;
  bool disponibilidade;

  OrderItem({
    this.produtoId,
    required this.quantidade,
    required this.precoUnitario,
    required this.disponibilidade,
  });

  OrderItem copyWith({
    int? produtoId,
    int? quantidade,
    double? precoUnitario,
    bool? disponibilidade,
  }) {
    return OrderItem(
      produtoId: produtoId ?? this.produtoId,
      quantidade: quantidade ?? this.quantidade,
      precoUnitario: precoUnitario ?? this.precoUnitario,
      disponibilidade: disponibilidade ?? this.disponibilidade,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'produtoId': produtoId,
      'quantidade': quantidade,
      'precoUnitario': precoUnitario,
      'disponibilidade': disponibilidade,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      produtoId: map['produtoId'] != null ? map['produtoId'] as int : null,
      quantidade: map['quantidade'] as int,
      precoUnitario: map['precoUnitario'] as double,
      disponibilidade: map['disponibilidade'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderItem(produtoId: $produtoId, quantidade: $quantidade, precoUnitario: $precoUnitario, disponibilidade: $disponibilidade)';
  }

  @override
  bool operator ==(covariant OrderItem other) {
    if (identical(this, other)) return true;

    return other.produtoId == produtoId &&
        other.quantidade == quantidade &&
        other.precoUnitario == precoUnitario &&
        other.disponibilidade == disponibilidade;
  }

  @override
  int get hashCode {
    return produtoId.hashCode ^
        quantidade.hashCode ^
        precoUnitario.hashCode ^
        disponibilidade.hashCode;
  }
}
