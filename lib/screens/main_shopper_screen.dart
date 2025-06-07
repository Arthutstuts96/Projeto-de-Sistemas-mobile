import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/profile_screen.dart';
import 'package:projeto_de_sistemas/screens/shopper/shopper_extract_screen.dart';
import 'package:projeto_de_sistemas/screens/shopper/shopper_order_screen.dart';
import 'package:projeto_de_sistemas/screens/shopper/shopperhome_screen.dart';

class MainShopperScreen extends StatefulWidget {
  final int initialIndex;

  const MainShopperScreen({super.key, this.initialIndex = 0});

  @override
  State<MainShopperScreen> createState() => _MainShopperScreenState();
}

class _MainShopperScreenState extends State<MainShopperScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  final List<Widget> _screens = [
    ShopperHomeScreen(),
    ShopperOrderScreen(),
    ShopperExtractScreen(),
    ProfileScreen(),
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
        physics: const NeverScrollableScrollPhysics(), // remove o swipe manual
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 228, 35, 35),
        selectedItemColor: const Color.fromARGB(255, 122, 122, 122),
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Pedido",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_sharp),
            label: "Extrato",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
