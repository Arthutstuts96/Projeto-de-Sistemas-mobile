import 'package:get_it/get_it.dart';
import 'package:projeto_de_sistemas/services/api/market_api.dart';
import 'package:projeto_de_sistemas/services/api/order_api.dart';
import 'package:projeto_de_sistemas/services/api/products_home_api.dart';
import 'package:projeto_de_sistemas/services/session/cart_session.dart';
import 'package:projeto_de_sistemas/services/session/order_session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'services/api/address_api.dart';
import 'services/session/user_session.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // --- DEPENDÊNCIAS EXTERNAS (Pacotes, etc.) ---.
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerLazySingleton<Dio>(() => Dio());

  // --- SERVIÇOS DA APLICAÇÃO (Classes de Lógica) ---
  getIt.registerLazySingleton<UserSession>(() => UserSession());
  getIt.registerLazySingleton<OrderSession>(() => OrderSession());
  getIt.registerLazySingleton<CartSession>(() => CartSession());
  getIt.registerLazySingleton<AddressApi>(() => AddressApi());
  getIt.registerLazySingleton<MarketApi>(() => MarketApi());
  getIt.registerLazySingleton<OrderApi>(() => OrderApi());
  getIt.registerLazySingleton<ProductControllerApi>(() => ProductControllerApi());
}