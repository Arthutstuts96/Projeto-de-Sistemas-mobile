import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/domain/models/users/market.dart';
import 'package:projeto_de_sistemas/screens/market_screen.dart';

class CardMarket extends StatelessWidget {
  const CardMarket({super.key, required this.market});
  final Market market;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MarketScreen(market: market)),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.asset(
                  "assets/images/market_image_placeholder.jpg",
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    market.name!,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Row(spacing: 4, children: [Text("4.3/5"), Icon(Icons.star)]),
                ],
              ),
              const Text('A 0km de distância de você • 0 vendas no último mês'),
              const Row(
                spacing: 4,
                children: [Icon(Icons.map_sharp, size: 16), Text('Atacado')],
              ),
              const Row(
                spacing: 4,
                children: [
                  Icon(Icons.timelapse_sharp, size: 16),
                  Text('Aberto das 6:00 até as 22:30'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
