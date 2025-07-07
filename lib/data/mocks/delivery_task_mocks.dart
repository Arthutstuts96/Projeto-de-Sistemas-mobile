//APENAS PARA TESTE,ATUALMENTE DESNECESSÁRIO

// import 'dart:math';
// import '../../domain/models/delivery_task_mock_model.dart';

// final _random = Random();

// // Lista base de onde os mocks são tirados
// List<DeliveryTaskMock> _listaBaseDeTasksMock = [
//   DeliveryTaskMock(
//     id: 'TASK_001',
//     nomeCliente: 'Fernanda Lima',
//     enderecoEntrega: 'Rua das Palmeiras, 100',
//     itensResumo: '1x Super Combo, 1x Suco Laranja',
//   ),
// ];

// DeliveryTaskMock? obterNovoDeliveryTaskMock() {
//   if (_listaBaseDeTasksMock.isEmpty) return null;

//   final baseTask =
//       _listaBaseDeTasksMock[_random.nextInt(_listaBaseDeTasksMock.length)];

//   // Retorna uma NOVA INSTÂNCIA para simular um novo pedido/tarefa única
//   return DeliveryTaskMock(
//     id: "${baseTask.id}_${DateTime.now().millisecondsSinceEpoch}", // Garante ID único para a simulação
//     nomeCliente: baseTask.nomeCliente,
//     enderecoEntrega: baseTask.enderecoEntrega,
//     itensResumo: baseTask.itensResumo,
//     status: DeliveryTaskStatusMock.aguardandoAceiteEntregador,
//   );
// }
