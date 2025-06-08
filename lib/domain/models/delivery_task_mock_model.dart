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
  });
}
