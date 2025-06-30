import 'package:dio/dio.dart';
import 'package:projeto_de_sistemas/domain/models/users/market.dart';
import 'package:projeto_de_sistemas/locator.dart';
import 'package:projeto_de_sistemas/services/session/user_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarketApi {
  final Dio _dio;
  final SharedPreferences _prefs;
  final UserSession _userSession;

  MarketApi()
    : _dio = getIt<Dio>(),
      _prefs = getIt<SharedPreferences>(),
      _userSession = getIt<UserSession>();

  MarketApi.testable({
    required Dio dio,
    required SharedPreferences prefs,
    required UserSession userSession,
  }) : _dio = dio,
       _prefs = prefs,
       _userSession = userSession;

  Future<List<Market>> getAllMarkets() async {
    //TODO: buscar mercados pela api
    return [Market("AssandoAí Atacadista"), Market("Supermercado Pague Bem")];
  }
}
