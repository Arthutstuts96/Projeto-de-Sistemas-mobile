import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/components/market/card_market.dart';
import 'package:projeto_de_sistemas/screens/order-screens/order.dart';
import 'package:projeto_de_sistemas/screens/order-screens/order_history.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(horizontal: 8),
        backgroundColor: Color(0xFFFFAA00),
        title: Text(
          "Pedido",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          tabs: <Tab>[
            Tab(text: "Seu pedido", icon: Icon(Icons.bookmark)),
            Tab(text: "Histórico", icon: Icon(Icons.history)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Order(),
          OrderHistory(),
        ],
      ),
    );
  }
}
