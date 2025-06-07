// lib/screens/deliveryhome_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../controllers/active_delivery_controller.dart';
import '../domain/models/delivery_task_mock_model.dart';
import 'components/new_delivery_popup.dart';
import 'package:geolocator/geolocator.dart';

class DeliveryHomeScreen extends StatefulWidget {
  const DeliveryHomeScreen({super.key});

  @override
  State<DeliveryHomeScreen> createState() => _DeliveryHomeScreenState();
}

class _DeliveryHomeScreenState extends State<DeliveryHomeScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Future<void> _goToUserLocation() async {
    await Permission.location.request();
    Position position = await Geolocator.getCurrentPosition();
    print(position);
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        16,
      ),
    );
  }

  final double _initialChildSize = 0.1;
  final double _minChildSize = 0.1;
  final double _maxChildSize = 0.7;
  int _selectedIndex = 0;
  final DraggableScrollableController _modalController =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowNewTaskPopup();
    });
  }

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
          _goToUserLocation();
        },
        child: const Icon(Icons.my_location),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: _minimizeModal,
            child: GoogleMap(
              zoomControlsEnabled: false,
              compassEnabled: false,
              myLocationEnabled: true,
              onMapCreated:
                  (GoogleMapController controller) =>
                      _controller.complete(controller),
              initialCameraPosition: const CameraPosition(
                target: LatLng(-23.560334, 45.634915),
                zoom: 10,
              ),
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
                  // Consumer focado no conteúdo do sheet
                  builder: (context, deliveryController, child) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: _buildSheetContent(
                        context,
                        deliveryController.currentTask,
                        deliveryController,
                      ),
                    );
                  },
                ),
              );
            },
          ),
          // Seu _TopStatusBar customizado (agora como um widget otimizado)
          _TopStatusBar(
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

  Widget _buildSheetContent(
    BuildContext context,
    DeliveryTaskMock? task,
    ActiveDeliveryController deliveryController,
  ) {
    // O título da tarefa/pedido será exibido aqui dentro, como antes.
    // Usando task.itensResumo para o título principal da tarefa, conforme seu model atual.
    if (task != null && task.status != DeliveryTaskStatusMock.entregue) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 0, bottom: 10),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
            Text(
              'Tarefa: ${task.itensResumo}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildTaskDetailRow(
              'ID Simulado:',
              task.id.split('_').last,
            ), // Mostrando só a parte final do ID
            _buildTaskDetailRow('Cliente:', task.nomeCliente),
            _buildTaskDetailRow('Endereço:', task.enderecoEntrega),
            const SizedBox(height: 16),
            const Text(
              'Status Atual:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              _getStatusText(task.status),
              style: TextStyle(
                fontSize: 18,
                color: _getStatusColor(task.status),
              ),
            ),
            const SizedBox(height: 24),
            if (task.status == DeliveryTaskStatusMock.aceitoPeloEntregador)
              _buildActionButton(
                context: context,
                label: 'CONFIRMAR COLETA',
                onPressed: () => deliveryController.confirmCollection(),
                color: Colors.orange,
              ),
            if (task.status == DeliveryTaskStatusMock.coletadoPeloEntregador)
              _buildActionButton(
                context: context,
                label: 'CONFIRMAR ENTREGA',
                onPressed: () => deliveryController.confirmDelivery(),
                color: Colors.green,
              ),
            const SizedBox(height: 20),
          ],
        ),
      );
    } else if (task != null && task.status == DeliveryTaskStatusMock.entregue) {
      return Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Entrega "${task.itensResumo}" Concluída!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      deliveryController.clearCurrentTask();
                      _minimizeModal();
                    },
                    child: const Text("OK / Ver Novas Tarefas"),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      // Conteúdo padrão quando não há tarefa ativa
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Novidades',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [Image.asset("assets/images/delivery.png")],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildInfoCard('Seus ganhos', [
                    'Ganhos do dia',
                    'R\$ 100,00 (mock)',
                    'Saldo total: R\$ 1000,00 (mock)',
                  ]),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInfoCard('Rotas', [
                    'Rotas aceitas: 15 (mock)',
                    'Finalizadas: 12 (mock)',
                    'Recusadas: 3 (mock)',
                  ]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      );
    }
  }

  Widget _buildInfoCard(String title, List<String> details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                details.map((text) {
                  final isCurrency = text.startsWith('R\$');
                  return Text(
                    text,
                    style: TextStyle(
                      fontSize: (isCurrency ? 16 : 14),
                      fontWeight:
                          (isCurrency ? FontWeight.bold : FontWeight.normal),
                      color: Colors.black,
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _getStatusText(DeliveryTaskStatusMock status) {
    switch (status) {
      case DeliveryTaskStatusMock.aguardandoAceiteEntregador:
        return 'Aguardando Aceite';
      case DeliveryTaskStatusMock.aceitoPeloEntregador:
        return 'Aceita - Pronta para Coleta';
      case DeliveryTaskStatusMock.coletadoPeloEntregador:
        return 'Coletada - Em Rota de Entrega';
      case DeliveryTaskStatusMock.entregue:
        return 'Entregue';
    }
  }

  Color _getStatusColor(DeliveryTaskStatusMock status) {
    switch (status) {
      case DeliveryTaskStatusMock.aceitoPeloEntregador:
        return Colors.blueAccent;
      case DeliveryTaskStatusMock.coletadoPeloEntregador:
        return Colors.orangeAccent;
      case DeliveryTaskStatusMock.entregue:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
    Color? color,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        minimumSize: const Size(double.infinity, 50),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}

class _TopStatusBar extends StatelessWidget {
  final VoidCallback checkAndShowNewTaskPopupCallback;
  final DraggableScrollableController Function() getModalControllerCallback;
  final double Function() getMaxChildSizeCallback;

  const _TopStatusBar({
    required this.checkAndShowNewTaskPopupCallback,
    required this.getModalControllerCallback,
    required this.getMaxChildSizeCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<
      ActiveDeliveryController,
      ({bool isTaskActive, DeliveryTaskMock? task})
    >(
      selector:
          (_, controller) => (
            isTaskActive:
                controller.currentTask != null &&
                controller.currentTask!.status !=
                    DeliveryTaskStatusMock.entregue,
            task: controller.currentTask,
          ),
      builder: (context, data, _) {
        final deliveryController = Provider.of<ActiveDeliveryController>(
          context,
          listen: false,
        );

        String statusText = "Disponível";
        Color statusColor = const Color.fromRGBO(0, 128, 0, 1);

        if (data.isTaskActive) {
          statusText = "Em Entrega";
          statusColor = Colors.orange;
        }

        VoidCallback? statusAction =
            !data.isTaskActive
                ? () {
                  print("Status 'Disponível' clicado. Verificando pop-up...");
                  checkAndShowNewTaskPopupCallback();

                  if (deliveryController.currentTask == null &&
                      context.mounted) {
                    final modalController = getModalControllerCallback();
                    final maxChildSize = getMaxChildSizeCallback();
                    modalController.animateTo(
                      maxChildSize * 0.3,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Nenhuma nova tarefa encontrada.'),
                      ),
                    );
                  }
                }
                : null;

        return Positioned(
          top: 55,
          left: (MediaQuery.of(context).size.width - 300) / 2,
          child: Container(
            width: 300,
            height: 40,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 190, 190, 190),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  InkWell(
                    onTap: statusAction,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: Text(
                          statusText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
