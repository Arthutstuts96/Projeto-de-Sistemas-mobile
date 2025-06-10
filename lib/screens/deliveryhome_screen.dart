import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projeto_de_sistemas/services/location_service.dart';
import 'package:provider/provider.dart';
import '../controllers/active_delivery_controller.dart';
import 'components/new_delivery_popup.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projeto_de_sistemas/screens/components/delivery/top_status_bar.dart';
import 'package:projeto_de_sistemas/screens/components/delivery/delivery_task_sheet_content.dart';

class DeliveryHomeScreen extends StatefulWidget {
  const DeliveryHomeScreen({super.key});

  @override
  State<DeliveryHomeScreen> createState() => _DeliveryHomeScreenState();
}

class _DeliveryHomeScreenState extends State<DeliveryHomeScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final LocationService locationService = LocationService();
  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(-23.560334, 45.634915), // Coordenadas de exemplo
    zoom: 10,
  );

  CameraPosition _initialCameraPosition = _kInitialPosition;
  @override
  void initState() {
    super.initState();
    _initializeMapCamera();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowNewTaskPopup();
    });
  }

  Future<void> _initializeMapCamera() async {
    try {
      Position? lastKnownPosition =
          await locationService.getLastKnownLocation();
      if (lastKnownPosition != null) {
        setState(() {
          _initialCameraPosition = CameraPosition(
            target: LatLng(
              lastKnownPosition.latitude,
              lastKnownPosition.longitude,
            ),
            zoom: 16,
          );
        });
      }

      // 2. Tentar obter a localização atual com mais precisão
      Position currentPosition = await locationService.getCurrentLocation();
      if (currentPosition != null && mounted) {
        setState(() {
          _initialCameraPosition = CameraPosition(
            target: LatLng(currentPosition.latitude, currentPosition.longitude),
            zoom: 16,
          );
        });
        if (_controller.isCompleted) {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newLatLngZoom(
              LatLng(currentPosition.latitude, currentPosition.longitude),
              16,
            ),
          );
        }
      }
    } catch (e) {
      print(
        "Erro ao inicializar câmera do mapa com localização do usuário: $e",
      );
    }
  }

  final double _initialChildSize = 0.1;
  final double _minChildSize = 0.1;
  final double _maxChildSize = 0.7;
  int _selectedIndex = 0;
  final DraggableScrollableController _modalController =
      DraggableScrollableController();

  void _checkAndShowNewTaskPopup() {
    if (!mounted) return;
    final deliveryController = Provider.of<ActiveDeliveryController>(
      context,
      listen: false,
    );

    if (deliveryController.shouldShowNewTaskPopup) {
      deliveryController.markPopupAsShown();
      showNewDeliveryPopup(
        context: context,
        task: deliveryController.currentTask!,
        onAccept: () {
          deliveryController.acceptTask();
          _modalController.animateTo(
            _maxChildSize * 0.8,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        onDecline: () {
          deliveryController.declineTask();
        },
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Navegar para Perfil (Implementar)")),
      );
    } else if (index == 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Navegar para Histórico (Implementar)")),
      );
    }
  }

  void _minimizeModal() {
    _modalController.animateTo(
      _minChildSize,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _modalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _initializeMapCamera();
        },
        backgroundColor: const Color(0xFFFFAA00),
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: _minimizeModal,
            child: GoogleMap(
              zoomControlsEnabled: false,
              compassEnabled: false,
              mapType: MapType.terrain,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                controller.animateCamera(
                  CameraUpdate.newCameraPosition(_initialCameraPosition),
                );
              },
              initialCameraPosition: _initialCameraPosition,
            ),
          ),
          DraggableScrollableSheet(
            controller: _modalController,
            initialChildSize: _initialChildSize,
            minChildSize: _minChildSize,
            maxChildSize: _maxChildSize,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Consumer<ActiveDeliveryController>(
                  builder: (context, deliveryController, child) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: DeliveryTaskSheetContent(
                        task: deliveryController.currentTask,
                        deliveryController: deliveryController,
                      ),
                    );
                  },
                ),
              );
            },
          ),
          TopStatusBar(
            checkAndShowNewTaskPopupCallback: _checkAndShowNewTaskPopup,
            getModalControllerCallback: () => _modalController,
            getMaxChildSizeCallback: () => _maxChildSize,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.delivery_dining),
            label: 'Entrega',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Histórico',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
