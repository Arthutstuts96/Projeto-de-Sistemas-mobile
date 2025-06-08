import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../domain/models/delivery_task_mock_model.dart';
import 'package:projeto_de_sistemas/services/navigation_service.dart';
import 'package:geolocator/geolocator.dart';

class ActiveDeliveryController with ChangeNotifier {
  DeliveryTaskMock? _currentTask;
  bool _popupForCurrentTaskShown = false;
  final String _simulatedDriverId = "driver_beta_01";
  final NavigationService _navigationService = NavigationService();

  DeliveryTaskMock? get currentTask => _currentTask;

  bool get shouldShowNewTaskPopup =>
      _currentTask != null &&
      _currentTask!.status ==
          DeliveryTaskStatusMock.aguardandoAceiteEntregador &&
      !_popupForCurrentTaskShown;

  void simulateNewTaskAvailable({
    required String orderId,
    required String customerName,
    required String deliveryAddress,
    required String itemsSummary,

    required double mercadoLatitude,
    required double mercadoLongitude,
    required double clientLatitude,
    required double clientLongitude,
  }) {
    if (_currentTask == null ||
        _currentTask!.status == DeliveryTaskStatusMock.entregue) {
      _currentTask = DeliveryTaskMock(
        id: "TASK_FROM_${orderId}_${DateTime.now().millisecondsSinceEpoch}", // Cria um ID de tarefa baseado no pedido
        nomeCliente: customerName,
        enderecoEntrega: deliveryAddress,
        itensResumo: itemsSummary,
        status: DeliveryTaskStatusMock.aguardandoAceiteEntregador,

        mercadoLatitude: mercadoLatitude,
        mercadoLongitude: mercadoLongitude,
        clientLatitude: clientLatitude,
        clientLongitude: clientLongitude,
      );
      _popupForCurrentTaskShown = false;
      print(
        "NOVA TAREFA DE ENTREGA (DO PEDIDO REAL $orderId): ${_currentTask!.id}",
      );
      notifyListeners();
    } else {
      print(
        "Ainda há uma tarefa ativa (${_currentTask!.id}), nova tarefa (do pedido $orderId) não gerada.",
      );
    }
  }

  void acceptTask() {
    if (_currentTask != null) {
      _currentTask!.status = DeliveryTaskStatusMock.aceitoPeloEntregador;
      _currentTask!.idEntregadorAtribuido = _simulatedDriverId;
      print(
        "TAREFA ACEITA: ${_currentTask!.id} pelo entregador $_simulatedDriverId",
      );
      _popupForCurrentTaskShown = true;
      notifyListeners();
    }
  }

  void declineTask() {
    if (_currentTask != null) {
      print("TAREFA RECUSADA: ${_currentTask!.id}");
      _clearCurrentTask();
    }
  }

  void confirmCollection() {
    if (_currentTask != null &&
        _currentTask!.status == DeliveryTaskStatusMock.aceitoPeloEntregador) {
      _currentTask!.status = DeliveryTaskStatusMock.coletadoPeloEntregador;
      print("TAREFA COLETADA: ${_currentTask!.id}");
      notifyListeners();
    }
  }

  void confirmDelivery() {
    if (_currentTask != null &&
        _currentTask!.status == DeliveryTaskStatusMock.coletadoPeloEntregador) {
      _currentTask!.status = DeliveryTaskStatusMock.entregue;
      print("TAREFA ENTREGUE: ${_currentTask!.id}");
      notifyListeners();
    }
  }

  void markPopupAsShown() {
    _popupForCurrentTaskShown = true;
  }

  void clearCurrentTask() {
    _clearCurrentTask();
  }

  void _clearCurrentTask() {
    _currentTask = null;
    _popupForCurrentTaskShown = false;
    notifyListeners();
  }

  Future<void> startNavigationToMercado(BuildContext context) async {
    if (currentTask == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nenhuma tarefa ativa para navegar.")),
      );
      return;
    }

    Position? motoboyLocation;
    try {
      motoboyLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print("Erro ao obter localização do motoboy: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Não foi possível obter sua localização atual."),
        ),
      );
      return;
    }

    if (motoboyLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Localização do motoboy não disponível.")),
      );
      return;
    }
    final double mercadoLat = currentTask!.mercadoLatitude;
    final double mercadoLng = currentTask!.mercadoLongitude;

    final bool launched = await _navigationService.navigateTo(
      startLatitude: motoboyLocation.latitude,
      startLongitude: motoboyLocation.longitude,
      endLatitude: mercadoLat,
      endLongitude: mercadoLng,
      isToMercado: true,
    );

    if (launched) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Iniciando navegação para o mercado...")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Falha ao iniciar navegação. Verifique se Waze ou Google Maps estão instalados.",
          ),
        ),
      );
    }
  }
  Future<void> startNavigationToClient(BuildContext context) async {
    if (currentTask == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Nenhuma tarefa ativa para navegar até o cliente."),
        ),
      );
      return;
    }

    // 1. Obter a localização atual do motoboy (origem da rota)
    // Mesmo que o ideal seja do mercado, para o teste MVP, usamos a do motoboy
    Position? motoboyLocation;
    try {
      motoboyLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print("Erro ao obter localização do motoboy para cliente: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Não foi possível obter sua localização atual para navegar até o cliente.",
          ),
        ),
      );
      return;
    }

    if (motoboyLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Localização do motoboy não disponível para navegar até o cliente.",
          ),
        ),
      );
      return;
    }

    // 2. Coordenadas do cliente (destino da rota)
    final double clientLat =
        currentTask!.clientLatitude!; // Use ! pois já garantiu que não é null
    final double clientLng = currentTask!.clientLongitude!; //

    // 3. Chamar o serviço de navegação
    final bool launched = await _navigationService.navigateTo(
      startLatitude: motoboyLocation.latitude,
      startLongitude: motoboyLocation.longitude,
      endLatitude: clientLat,
      endLongitude: clientLng,
      isToMercado:
          false, // <--- Indica que NÃO é para o mercado (é para o cliente)
    );

    if (launched) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Iniciando navegação para o cliente...")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Falha ao iniciar navegação. Verifique se Waze ou Google Maps estão instalados.",
          ),
        ),
      );
    }
  }
}
