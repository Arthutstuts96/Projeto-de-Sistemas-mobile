import 'package:flutter/foundation.dart'; // Apenas para debug/comparação se for usar em Collections

class CategoryModel {
  final String id;
  final String name;
  // Adicione outras propriedades se a categoria tiver (ex: 'imageUrl')

  CategoryModel({required this.id, required this.name});

  // Opcional: para comparação em listas ou debug
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CategoryModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
