import 'package:projeto_de_sistemas/domain/models/market.dart';
import 'package:projeto_de_sistemas/services/api/market_api.dart';

class MarketController {
  final MarketApi _marketApi = MarketApi();

  Future<List<Market>> getAllMarkets() async {
    return await _marketApi.getAllMarkets();
  }
}