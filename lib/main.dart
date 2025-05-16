import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/cart_screen.dart';
import 'package:projeto_de_sistemas/screens/order_screen.dart';
import 'package:projeto_de_sistemas/screens/search_products_screen.dart';
import 'package:projeto_de_sistemas/screens/splash_screen.dart';
import 'package:projeto_de_sistemas/screens/login_screen.dart';
import 'package:projeto_de_sistemas/screens/home_screen.dart';
import 'package:projeto_de_sistemas/screens/main_screen.dart';
import 'package:projeto_de_sistemas/screens/perfil_screen.dart';
import 'package:projeto_de_sistemas/screens/deliveryhome_screen.dart';

void main() {
  runApp(DevicePreview(
      enabled: true,
      tools: [...DevicePreview.defaultTools],
      builder: (context) => const TrazAi(),
    ),);
}

class TrazAi extends StatelessWidget {
  const TrazAi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "splash_screen": (context) => const SplashScreen(),
        "login_screen": (context) =>  LoginScreen(),
        "home_screen": (context) =>  HomeScreen(),
        "main_screen": (context) =>  MainScreen(),
        "perfil_screen": (context) =>   PerfilScreen(),
        "delivery_screen": (context) =>  const DeliveryHomeScreen(),
        "cart": (context) =>  CartScreen(),
        "search_products": (context) =>  SearchProductsScreen(),
        "order_screen": (context) =>  OrderScreen(),
      },
      initialRoute: "order_screen",
    );
  }
}
