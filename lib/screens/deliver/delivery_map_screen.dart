import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projeto_de_sistemas/services/location_service.dart';
import 'package:provider/provider.dart';
import 'package:projeto_de_sistemas/controllers/active_delivery_controller.dart';
import 'package:projeto_de_sistemas/screens/components/new_delivery_popup.dart';
import 'package:projeto_de_sistemas/screens/components/delivery/top_status_bar.dart';
import 'package:projeto_de_sistemas/screens/components/delivery/delivery_task_sheet_content.dart';

class DeliveryMapScreen extends StatefulWidget {
  // <--- NOVA TELA PARA O MAPA
  const DeliveryMapScreen({super.key});

  @override
  State<DeliveryMapScreen> createState() => _DeliveryMapScreenState();
}

class _DeliveryMapScreenState extends State<DeliveryMapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final LocationService locationService = LocationService();
  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(-23.560334, 45.634915), 
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

      Position currentPosition = await locationService.getCurrentLocation();
      if (mounted) {
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
      return;
    }
  }

  final double _initialChildSize = 0.1;
  final double _minChildSize = 0.1;
  final double _maxChildSize = 0.7;
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
      // <--- Scaffold interno para o FloatingActionButton
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _initializeMapCamera();
        },
        backgroundColor: const Color.fromARGB(255, 87, 248, 0),
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
    );
  }
}
