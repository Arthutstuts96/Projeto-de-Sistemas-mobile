import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/shopper_controller.dart';
import 'package:projeto_de_sistemas/locator.dart';
import 'package:projeto_de_sistemas/screens/main_shopper_screen.dart';
import 'package:provider/provider.dart';
import 'package:projeto_de_sistemas/controllers/active_delivery_controller.dart';
import 'package:projeto_de_sistemas/controllers/products_controller.dart';
import 'package:projeto_de_sistemas/screens/cart_screen.dart';
import 'package:projeto_de_sistemas/screens/finish-order-screens/finish_order_screen.dart';
import 'package:projeto_de_sistemas/screens/order-screens/order_screen.dart';
import 'package:projeto_de_sistemas/screens/product_screen.dart';
import 'package:projeto_de_sistemas/screens/search_products_screen.dart';
import 'package:projeto_de_sistemas/screens/login-register-screens/splash_screen.dart';
import 'package:projeto_de_sistemas/screens/login-register-screens/login_screen.dart';
import 'package:projeto_de_sistemas/screens/home_screen.dart';
import 'package:projeto_de_sistemas/screens/main_screen.dart';
import 'package:projeto_de_sistemas/screens/profile_screen.dart';
import 'package:projeto_de_sistemas/screens/deliveryhome_screen.dart';
import 'package:projeto_de_sistemas/controllers/delivery_history_controller.dart';

Future<void> main() async {
  // Busca todas as dependências ANTES de iniciar a aplicação
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  runApp(
    DevicePreview(
      enabled: false,
      tools: [...DevicePreview.defaultTools],
      builder:
          (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ActiveDeliveryController()),
              ChangeNotifierProvider(create: (_) => HomeProductsController()),
              ChangeNotifierProvider(create: (_) => SearchScreenController()),
              ChangeNotifierProvider(create: (_) => DeliveryHistoryController()),
              ChangeNotifierProvider(create: (_) => ShopperController()),
            ],
            child: const TrazAi(),
          ),
    ),
  );
}

class TrazAi extends StatelessWidget {
  const TrazAi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins', useMaterial3: true),
      debugShowCheckedModeBanner: false,
      routes: {
        "splash_screen": (context) => const SplashScreen(),
        "login_screen": (context) => LoginScreen(),
        "home_screen": (context) => HomeScreen(),
        "main_screen": (context) => MainScreen(),
        "main_shopper_screen": (context) => MainShopperScreen(),
        "perfil_screen": (context) => ProfileScreen(),
        "delivery_screen": (context) => const DeliveryHomeScreen(),
        "cart": (context) => CartScreen(),
        "search_products": (context) => SearchProductsScreen(),
        "order_screen": (context) => OrderScreen(),
        "finish_order_screen": (context) => FinishOrderScreen(),
        "product_screen": (context) => ProductScreen(),
      },
      initialRoute: "splash_screen",
    );
  }
}
