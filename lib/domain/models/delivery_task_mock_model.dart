enum DeliveryTaskStatusMock {
  aguardandoAceiteEntregador,
  aceitoPeloEntregador,
  coletadoPeloEntregador,
  entregue,
}

class DeliveryTaskMock {
  final String id;
  final String nomeCliente;
  final String enderecoEntrega;
  final String itensResumo;
  DeliveryTaskStatusMock status;
  String? idEntregadorAtribuido;
  // Mock das coordenadas de localização dos mercado and clientes
  final double mercadoLatitude;
  final double mercadoLongitude;
  final double clientLatitude;
  final double clientLongitude;
  final DateTime criadoEm;

  DeliveryTaskMock({
    required this.id,
    required this.nomeCliente,
    required this.enderecoEntrega,
    required this.itensResumo,
    this.status = DeliveryTaskStatusMock.aguardandoAceiteEntregador,
    this.idEntregadorAtribuido,

    required this.mercadoLatitude,
    required this.mercadoLongitude,
    required this.clientLatitude,
    required this.clientLongitude,
    required this.criadoEm,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomeCliente': nomeCliente,
      'enderecoEntrega': enderecoEntrega,
      'itensResumo': itensResumo,
      'status': status.toString().split('.').last, // Salva o nome do enum como String
      'idEntregadorAtribuido': idEntregadorAtribuido,
      'mercadoLatitude': mercadoLatitude,
      'mercadoLongitude': mercadoLongitude,
      'clientLatitude': clientLatitude,
      'clientLongitude': clientLongitude,
      'criadoEm': criadoEm.toIso8601String(),
    };
  }

  // --- NOVO: Construtor de fábrica para criar DeliveryTaskMock a partir de um Map (JSON) ---
  factory DeliveryTaskMock.fromJson(Map<String, dynamic> json) {
    return DeliveryTaskMock(
      id: json['id'] as String,
      nomeCliente: json['nomeCliente'] as String,
      enderecoEntrega: json['enderecoEntrega'] as String,
      itensResumo: json['itensResumo'] as String,
      // Converte a String de volta para o Enum
      status: DeliveryTaskStatusMock.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => DeliveryTaskStatusMock.entregue, // Default se o status não for encontrado
      ),
      idEntregadorAtribuido: json['idEntregadorAtribuido'] as String?,
      mercadoLatitude: json['mercadoLatitude'] as double,
      mercadoLongitude: json['mercadoLongitude'] as double,
      clientLatitude: json['clientLatitude'] as double,
      clientLongitude: json['clientLongitude'] as double,
      criadoEm: DateTime.parse(json['criadoEm'] as String), // Converte a String de volta para DateTime
    );
  }

  // Se você tiver um copyWith, certifique-se de que ele também lide com as novas propriedades.
  // E com os enums.
  DeliveryTaskMock copyWith({
    String? id,
    String? nomeCliente,
    String? enderecoEntrega,
    String? itensResumo,
    DeliveryTaskStatusMock? status,
    String? idEntregadorAtribuido,
    double? mercadoLatitude,
    double? mercadoLongitude,
    double? clientLatitude,
    double? clientLongitude,
    DateTime? criadoEm,
  }) {
    return DeliveryTaskMock(
      id: id ?? this.id,
      nomeCliente: nomeCliente ?? this.nomeCliente,
      enderecoEntrega: enderecoEntrega ?? this.enderecoEntrega,
      itensResumo: itensResumo ?? this.itensResumo,
      status: status ?? this.status,
      idEntregadorAtribuido: idEntregadorAtribuido ?? this.idEntregadorAtribuido,
      mercadoLatitude: mercadoLatitude ?? this.mercadoLatitude,
      mercadoLongitude: mercadoLongitude ?? this.mercadoLongitude,
      clientLatitude: clientLatitude ?? this.clientLatitude,
      clientLongitude: clientLongitude ?? this.clientLongitude,
      criadoEm: criadoEm ?? this.criadoEm,
    );
  }
}
