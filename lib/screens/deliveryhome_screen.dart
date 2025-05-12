import 'package:flutter/material.dart';

class DeliveryHomeScreen extends StatefulWidget {
  const DeliveryHomeScreen({super.key});

  @override
  State<DeliveryHomeScreen> createState() => _DeliveryHomeScreenState();
}

class _DeliveryHomeScreenState extends State<DeliveryHomeScreen> {
  final double _initialChildSize =
      0.1; // Tamanho inicial do modal (10% da tela)
  final double _minChildSize = 0.1; // Tamanho mínimo ao arrastar para baixo
  final double _maxChildSize = 0.5; // Tamanho máximo ao arrastar para cima
  int _selectedIndex = 0; // Índice da aba selecionada na barra de navegação
  final DraggableScrollableController _modalController =
      DraggableScrollableController(); // Inicialização direta

  // Função para lidar com a mudança de aba (opcional)
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Aqui você pode adicionar lógica para navegar para outras telas, se necessário
  }

  // Função para abaixar o modal ao clicar fora
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
      body: Stack(
        children: [
          // Mapa com GestureDetector para abaixar o modal ao clicar fora
          GestureDetector(
            onTap: _minimizeModal, // Abaixa o modal em vez de fechar
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
          // Modal arrastável
          DraggableScrollableSheet(
            controller: _modalController, // Usamos o controlador
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
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle para arrastar
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
                      // Primeiro box: Imagem
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        color: const Color.fromARGB(255, 255, 255, 255),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/delivery.png",
                              errorBuilder: (context, error, stackTrace) {
                                return const Text(
                                  'Erro ao carregar delivery.png',
                                  style: TextStyle(color: Colors.red),
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Seus ganhos',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Ganhos do dia',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          'R\$ 100,00',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Saldo total: R\$ 1000,00',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rotas',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Rotas aceitas: 15',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          'Finalizadas: 12',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          'Recusadas: 3',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 55,
            left:
                (MediaQuery.of(context).size.width - 300) /
                2, // Centraliza a box horizontalmente
            child: Container(
              width: 300, // Define a largura fixa
              height: 40, // Define a altura fixa
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 190, 190, 190),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween, // Mantém o botão de voltar à esquerda
                    children: [
                      // Botão de voltar no canto esquerdo
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.pop(context); // Volta para a tela anterior
                        },
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                      // Elementos centralizados
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // Centraliza os elementos
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 128, 0, 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              child: Text(
                                'Disponível',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                      // Espaço vazio à direita para balancear o layout
                      SizedBox(width: 1),
                      Icon(
                        Icons.notifications,
                        color: Colors.orange,
                        size: 20,
                      ), // Ajusta o espaço para centralizar o conteúdo do meio
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // Barra de navegação inferior
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
