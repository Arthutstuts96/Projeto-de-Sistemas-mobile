import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    // ComprarScreen(),
    // BolsaScreen(),
    // PedidoScreen(),
    // PerfilScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFFAA00),
        selectedItemColor: const Color(0xFF3C3C3C),
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Comprar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Bolsa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: "Pedido",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}
