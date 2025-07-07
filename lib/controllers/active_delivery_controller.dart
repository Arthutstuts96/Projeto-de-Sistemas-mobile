import 'package:flutter/material.dart';
import '../domain/models/delivery_task_mock_model.dart';
import 'package:projeto_de_sistemas/services/navigation_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projeto_de_sistemas/services/session/delivery_session.dart';

class ActiveDeliveryController with ChangeNotifier {
  DeliveryTaskMock? _currentTask;
  bool _popupForCurrentTaskShown = false;
  final String _simulatedDriverId = "driver_beta_01";
  final NavigationService _navigationService = NavigationService();
  final DeliveryHistorySession _historySession = DeliveryHistorySession();

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
    DateTime? orderCreationDate,
    required DateTime criadoEm,
  }) {
    if (_currentTask == null ||
        _currentTask!.status == DeliveryTaskStatusMock.entregue) {
      _currentTask = DeliveryTaskMock(
        id: "TASK_FROM_${orderId}_${DateTime.now().millisecondsSinceEpoch}", 
        nomeCliente: customerName,
        enderecoEntrega: deliveryAddress,
        itensResumo: itemsSummary,
        status: DeliveryTaskStatusMock.aguardandoAceiteEntregador,

        mercadoLatitude: mercadoLatitude,
        mercadoLongitude: mercadoLongitude,
        clientLatitude: clientLatitude,
        clientLongitude: clientLongitude,
        criadoEm: orderCreationDate ?? DateTime.now(),
      );
      _popupForCurrentTaskShown = false;
      notifyListeners();
    } else {
      return;
    }
  }

  void acceptTask() {
    if (_currentTask != null) {
      _currentTask!.status = DeliveryTaskStatusMock.aceitoPeloEntregador;
      _currentTask!.idEntregadorAtribuido = _simulatedDriverId;
      _popupForCurrentTaskShown = true;
      notifyListeners();
    }
  }

  void declineTask() {
    if (_currentTask != null) {
      _clearCurrentTask();
    }
  }

  void confirmCollection() {
    if (_currentTask != null &&
        _currentTask!.status == DeliveryTaskStatusMock.aceitoPeloEntregador) {
      _currentTask!.status = DeliveryTaskStatusMock.coletadoPeloEntregador;
      notifyListeners();
    }
  }

  void confirmDelivery() {
    if (_currentTask != null &&
        _currentTask!.status == DeliveryTaskStatusMock.coletadoPeloEntregador) {
      _currentTask!.status = DeliveryTaskStatusMock.entregue;
      _historySession.saveDeliveryToHistory(_currentTask!);
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Não foi possível obter sua localização atual."),
        ),
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

    Position? motoboyLocation;
    try {
      motoboyLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Não foi possível obter sua localização atual para navegar até o cliente.",
          ),
        ),
      );
      return;
    }

    final double clientLat =
        currentTask!.clientLatitude; 
    final double clientLng = currentTask!.clientLongitude; 

    final bool launched = await _navigationService.navigateTo(
      startLatitude: motoboyLocation.latitude,
      startLongitude: motoboyLocation.longitude,
      endLatitude: clientLat,
      endLongitude: clientLng,
      isToMercado:
          false, 
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
