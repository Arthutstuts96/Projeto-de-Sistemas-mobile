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

  DeliveryTaskMock({
    required this.id,
    required this.nomeCliente,
    required this.enderecoEntrega,
    required this.itensResumo,
    this.status = DeliveryTaskStatusMock.aguardandoAceiteEntregador,
    this.idEntregadorAtribuido,
  });
}
