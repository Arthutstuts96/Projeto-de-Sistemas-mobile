import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/order_controller.dart';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';
import 'package:projeto_de_sistemas/screens/components/register/button.dart';
import 'package:projeto_de_sistemas/screens/order-screens/current_order.dart';
import 'package:projeto_de_sistemas/screens/order-screens/order_history.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final OrderController _orderController = OrderController();
  Order? order;
  int _radioValue = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getOrder();
  }

  void getOrder() async {
    final loadedOrder = await _orderController.getOrderFromSession();
    setState(() {
      order = loadedOrder;
    });
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
        actionsPadding: const EdgeInsets.symmetric(horizontal: 8),
        backgroundColor: const Color(0xFFFFAA00),
        title: const Text(
          "Pedido",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        actions: [
          order != null
              ? IconButton(
                onPressed: () async {
                  int tempRadioValue = _radioValue;

                  final shouldCancel = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, setStateDialog) {
                          return AlertDialog(
                            title: const Text(
                              'Deseja realmente cancelar esse pedido?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RadioMenuButton(
                                  value: 0,
                                  groupValue: tempRadioValue,
                                  onChanged: (value) {
                                    setStateDialog(() {
                                      tempRadioValue = value!;
                                    });
                                  },
                                  child: const Text("O pedido atrasou"),
                                ),
                                RadioMenuButton(
                                  value: 1,
                                  groupValue: tempRadioValue,
                                  onChanged: (value) {
                                    setStateDialog(() {
                                      tempRadioValue = value!;
                                    });
                                  },
                                  child: const Text("Escolhi os itens errados"),
                                ),
                                RadioMenuButton(
                                  value: 2,
                                  groupValue: tempRadioValue,
                                  onChanged: (value) {
                                    setStateDialog(() {
                                      tempRadioValue = value!;
                                    });
                                  },
                                  child: const Text(
                                    "Coloquei o endereço errado",
                                  ),
                                ),
                                RadioMenuButton(
                                  value: 3,
                                  groupValue: tempRadioValue,
                                  onChanged: (value) {
                                    setStateDialog(() {
                                      tempRadioValue = value!;
                                    });
                                  },
                                  child: const Text(
                                    "Simplesmente mudei de ideia",
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Column(
                                  children: [
                                    Text(
                                      "Horário do pedido: ${order!.criadoEm.toIso8601String().split("T")[1].split(".")[0]}",
                                    ),
                                    Text("Pedido N°: ${order!.numeroPedido}"),
                                  ],
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed:
                                    () => Navigator.of(context).pop(false),
                                child: const Text('Não quero'),
                              ),
                              Button(
                                onPressed:
                                    () => Navigator.of(context).pop(true),
                                text: 'Sim, cancelar',
                                color: Colors.red,
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );

                  if (shouldCancel == true) {
                    setState(() {
                      _radioValue = tempRadioValue;
                    });
                    final result =
                        await _orderController.deleteOrderFromSession();
                    if (result) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Pedido cancelado com sucesso"),
                        ),
                      );
                    }
                  }
                },

                icon: const Icon(
                  Icons.warning_amber_rounded,
                  color: Color.fromARGB(255, 172, 47, 38),
                  size: 36,
                ),
              )
              : Container(),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          tabs: const <Tab>[
            Tab(text: "Seu pedido", icon: Icon(Icons.bookmark)),
            Tab(text: "Histórico", icon: Icon(Icons.history)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[CurrentOrder(order: order), const OrderHistory()],
      ),
    );
  }
}
