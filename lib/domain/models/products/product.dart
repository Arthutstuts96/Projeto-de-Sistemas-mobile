class Product {
  final int id;
  final String nome;
  final double precoUnitario;
  final String marca;
  final String imagem;

  Product({
    required this.id,
    required this.nome,
    required this.precoUnitario,
    required this.marca,
    required this.imagem,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      imagem: json['imagem'] ?? '',
      id: json['id'] ?? 0,
      nome: json['nome'] ?? '',
      precoUnitario:
          double.tryParse(json['preco_unitario']?.toString() ?? '0.0') ?? 0.0,
      marca: json['marca'] ?? '',
      // Ignora 'descricao', 'categoria', 'qtd_estoque', 'codigo_barras', 'qtd_avaliacoes', 'avaliacao', 'imagem'
    );
  }
}
