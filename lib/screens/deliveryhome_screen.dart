import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. IMPORTE O PROVIDER
import '../controllers/active_delivery_controller.dart'; // 2. IMPORTE SEU CONTROLLER
import '../domain/models/delivery_task_mock_model.dart'; // 3. IMPORTE SEU MODEL
import 'components/new_delivery_popup.dart'; // 4. IMPORTE SEU POP-UP

class DeliveryHomeScreen extends StatefulWidget {
  const DeliveryHomeScreen({super.key});

  @override
  State<DeliveryHomeScreen> createState() => _DeliveryHomeScreenState();
}

class _DeliveryHomeScreenState extends State<DeliveryHomeScreen> {
  final double _initialChildSize = 0.1;
  final double _minChildSize = 0.1;
  final double _maxChildSize =
      0.7; // Aumentei um pouco para caber mais detalhes da tarefa
  int _selectedIndex = 0;
  final DraggableScrollableController _modalController =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    // Adiciona um listener para animar o modal quando uma tarefa for aceita
    // Isso requer que o controller seja acessado após o primeiro frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Tenta mostrar o pop-up de nova tarefa se houver uma pendente
      _checkAndShowNewTaskPopup();

      // Listener para o controller (opcional, para animações)
      // Se você quiser que o modal expanda automaticamente ao aceitar um pedido.
      // Provider.of<ActiveDeliveryController>(context, listen: false).addListener(_handleControllerChanges);
    });
  }

  // void _handleControllerChanges() {
  //   // Opcional: Animar o modal quando uma tarefa é aceita
  //   final deliveryController = Provider.of<ActiveDeliveryController>(context, listen: false);
  //   if (deliveryController.currentTask != null &&
  //       deliveryController.currentTask!.status == DeliveryTaskStatusMock.aceitoPeloEntregador &&
  //       _modalController.size < (_maxChildSize * 0.8)) { // Se estiver muito pequeno
  //     _modalController.animateTo(
  //       _maxChildSize * 0.8, // Anima para 80% do tamanho máximo
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //     );
  //   }
  // }

  void _checkAndShowNewTaskPopup() {
    if (!mounted) return;
    final deliveryController = Provider.of<ActiveDeliveryController>(
      context,
      listen: false,
    );

    if (deliveryController.shouldShowNewTaskPopup) {
      deliveryController
          .markPopupAsShown(); // Evita mostrar múltiplas vezes para a mesma tarefa
      showNewDeliveryPopup(
        context: context,
        task: deliveryController.currentTask!,
        onAccept: () {
          deliveryController.acceptTask();
          // Animar o modal para cima para mostrar os detalhes da tarefa aceita
          _modalController.animateTo(
            _maxChildSize * 0.8, // Ou um valor fixo como 0.6
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        onDecline: () {
          deliveryController.declineTask();
          // O modal permanece como está ou minimiza
          // _minimizeModal(); // Opcional
        },
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Lógica de navegação para outras abas (Perfil, Histórico)
    // if (index == 1) Navigator.pushNamed(context, 'perfil_screen'); // Exemplo
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
    // Provider.of<ActiveDeliveryController>(context, listen: false).removeListener(_handleControllerChanges); // Se o listener for adicionado
    _modalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Usar Consumer para acessar o controller e reconstruir a UI quando o estado mudar
    return Consumer<ActiveDeliveryController>(
      builder: (context, deliveryController, child) {
        final DeliveryTaskMock? activeTask = deliveryController.currentTask;
        final bool isTaskActive =
            activeTask != null &&
            activeTask.status != DeliveryTaskStatusMock.entregue;

        // Verifica se um pop-up deve ser mostrado (caso a tela seja reconstruída e uma nova tarefa tenha chegado)
        // Essa chamada aqui deve ser cuidadosa para não causar loops de build se o estado mudar muito rápido.
        // A principal chamada é no initState. Esta é mais uma garantia.
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   _checkAndShowNewTaskPopup(); // Pode causar problemas se chamado diretamente no build.
        // });

        return Scaffold(
          body: Stack(
            children: [
              GestureDetector(
                onTap: _minimizeModal,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/GPS.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              DraggableScrollableSheet(
                controller: _modalController,
                initialChildSize: _initialChildSize,
                minChildSize: _minChildSize,
                maxChildSize: _maxChildSize,
                builder: (
                  BuildContext context,
                  ScrollController scrollController,
                ) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: _buildSheetContent(
                        context,
                        activeTask,
                        deliveryController,
                      ), // Conteúdo dinâmico
                    ),
                  );
                },
              ),
              // Barra de Status no Topo (modificada)
              _buildTopStatusBar(
                context,
                isTaskActive,
                activeTask,
                deliveryController,
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
            selectedItemColor: Colors.blue, // Exemplo
            unselectedItemColor: Colors.grey,
          ),
        );
      },
    );
  }

  // Widget para a barra de status no topo
  Widget _buildTopStatusBar(
    BuildContext context,
    bool isTaskActive,
    DeliveryTaskMock? task,
    ActiveDeliveryController controller,
  ) {
    String statusText = "Disponível";
    Color statusColor = Color.fromRGBO(0, 128, 0, 1); // Verde

    if (isTaskActive) {
      statusText = "Em Entrega";
      statusColor = Colors.orange; // Laranja para em entrega
    }

    // Para simular a procura por novas tarefas se estiver disponível
    VoidCallback? statusAction =
        !isTaskActive
            ? () {
              controller.simulateNewTaskAvailable();
              _checkAndShowNewTaskPopup(); // Tenta mostrar o popup imediatamente se uma tarefa for encontrada
            }
            : null;

    return Positioned(
      top: 55,
      left: (MediaQuery.of(context).size.width - 300) / 2,
      child: Container(
        width: 300,
        height: 40,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 190, 190, 190),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
              InkWell(
                // Torna o status clicável
                onTap: statusAction,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ), // Aumentado padding
                    child: Text(
                      statusText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // TODO: Adicionar lógica de notificação real aqui se necessário
              Icon(Icons.notifications_none, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Constrói o conteúdo DENTRO do DraggableScrollableSheet
  Widget _buildSheetContent(
    BuildContext context,
    DeliveryTaskMock? task,
    ActiveDeliveryController deliveryController,
  ) {
    if (task != null && task.status != DeliveryTaskStatusMock.entregue) {
      // Exibir detalhes da tarefa ativa
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle para arrastar
            Center(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 0,
                  bottom: 10,
                ), // Ajustado margin
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
            Text(
              'Tarefa Ativa: #${task.id.split('_').first}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildTaskDetailRow('Cliente:', task.nomeCliente),
            _buildTaskDetailRow('Endereço:', task.enderecoEntrega),
            _buildTaskDetailRow('Itens:', task.itensResumo),
            SizedBox(height: 16),
            Text(
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
            SizedBox(height: 24),
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
            SizedBox(height: 20), // Espaço extra no final
          ],
        ),
      );
    } else if (task != null && task.status == DeliveryTaskStatusMock.entregue) {
      // Mensagem de entrega concluída DENTRO do modal
      return Column(
        children: [
          Center(
            // Handle
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
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Entrega #${task.id.split('_').first} Concluída!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      deliveryController.clearCurrentTask();
                      _minimizeModal(); // Minimiza o modal
                    },
                    child: Text("OK / Ver Novas Tarefas"),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      // Conteúdo padrão do modal (Novidades, Ganhos, etc.)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            // Handle
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
            // Imagem
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [Image.asset("assets/images/delivery.png")],
            ),
          ),
          Padding(
            // Ganhos e Rotas
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

  // Widgets auxiliares que você já tinha, adaptados ou criados
  Widget _buildInfoCard(String title, List<String> details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Container(
          width: double.infinity, // Para preencher o Expanded
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                details.map((text) {
                  if (text.startsWith('R\$') || text.contains('aceitas:')) {
                    // Exemplo de estilização diferente
                    return Text(
                      text,
                      style: TextStyle(
                        fontSize: (text.startsWith('R\$') ? 16 : 14),
                        fontWeight:
                            (text.startsWith('R\$')
                                ? FontWeight.bold
                                : FontWeight.normal),
                        color: Colors.black,
                      ),
                    );
                  }
                  return Text(
                    text,
                    style: TextStyle(fontSize: 14, color: Colors.black),
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
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
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
        minimumSize: Size(double.infinity, 50),
        padding: EdgeInsets.symmetric(vertical: 16),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
      child: Text(label, style: TextStyle(color: Colors.white)),
    );
  }
}
