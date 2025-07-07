import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_de_sistemas/controllers/active_delivery_controller.dart';
import 'package:projeto_de_sistemas/domain/models/delivery_task_mock_model.dart';

class TopStatusBar extends StatelessWidget {
  final VoidCallback checkAndShowNewTaskPopupCallback;
  final DraggableScrollableController Function() getModalControllerCallback;
  final double Function() getMaxChildSizeCallback;

  const TopStatusBar({ // <--- Construtor renomeado
    super.key,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    child: IconButton(
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
                  ),
                  const SizedBox(width: 5), // Ajuste fino
                  Expanded(
                    child: Center(
                      child: InkWell(
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
                    ),
                  ),
                  const SizedBox(width: 18),
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