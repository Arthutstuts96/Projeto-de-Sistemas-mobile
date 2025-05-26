import 'package:projeto_de_sistemas/domain/models/market.dart';

class MarketApi{
  Future<List<Market>> getAllMarkets() async{
    //TODO: buscar mercados pela api
    return [Market("AssandoAí Atacadista"), Market("Supermercado Pague Bem")];
  }
}