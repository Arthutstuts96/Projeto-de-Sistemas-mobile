import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/deliver/delivery_history_screen.dart';
import 'package:projeto_de_sistemas/screens/deliver/delivery_map_screen.dart';
import 'package:projeto_de_sistemas/screens/profile_screen.dart';

class DeliveryHomeScreen extends StatefulWidget {
  // Agora atua como MainScreen do entregador
  const DeliveryHomeScreen({super.key});

  @override
  State<DeliveryHomeScreen> createState() => _DeliveryHomeScreenState();
}

class _DeliveryHomeScreenState extends State<DeliveryHomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  final List<Widget> _screens = [
    const DeliveryMapScreen(),
    const DeliveryHistoryScreen(), // Tela de histórico
    ProfileScreen(), // Tela de histórico
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Remove o swipe manual
        children: _screens, // As telas são os filhos do PageView
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 87, 248, 0), // Cor verde
        selectedItemColor: const Color.fromARGB(255, 122, 122, 122),
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Usa o método que controla o PageView
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.delivery_dining),
            label: "Entregas", // Aba do mapa/tarefas
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_sharp),
            label: "Histórico", // Aba de histórico
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Perfil", // Aba de perfil
          ),
        ],
      ),
    );
  }
}
