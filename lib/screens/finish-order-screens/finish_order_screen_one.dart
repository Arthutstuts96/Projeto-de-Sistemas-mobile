import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/address_controller.dart';
import 'package:projeto_de_sistemas/controllers/user_controller.dart';
import 'package:projeto_de_sistemas/domain/models/order/deliver_data.dart';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';
import 'package:projeto_de_sistemas/domain/models/users/address.dart';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:projeto_de_sistemas/screens/components/register/button.dart';
import 'package:projeto_de_sistemas/utils/widgets/address_dialog.dart';
import 'package:projeto_de_sistemas/utils/widgets/select_time.dart';

// ignore: must_be_immutable
class FinishOrderScreenOne extends StatefulWidget {
  FinishOrderScreenOne({
    super.key,
    required this.selected,
    required this.order,
  });
  String selected;
  Order order;

  @override
  State<FinishOrderScreenOne> createState() => _FinishOrderScreenOneState();
}

class _FinishOrderScreenOneState extends State<FinishOrderScreenOne> {
  Address? _address;
  late List<Address> addressList;
  final UserController _userController = UserController();
  final AddressController _addressController = AddressController();

  @override
  void initState() {
    super.initState();
    getAllAddresses();
  }

  Future<List<Address>?> getAllAddresses() async {
    User? user = await _userController.getCurrentUserFromSession();
    if (user != null) {
      var list = await _addressController.getAllAddressesByUserEmail(
        user: user,
      );
      setState(() {
        addressList = list;
        _address = addressList.firstWhere(
          (address) => widget.order.dadosEntrega?.enderecoId == address.id,
          orElse: () => list.first,
        );
        widget.order.dadosEntrega!.enderecoId = _address!.id!;
      });
      return list;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        const Text(
          "Escolha o endereço de entrega",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Row(
          children: [
            const Icon(Icons.location_on_outlined, size: 24),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                "Quadra ${_address?.quadra ?? "não especificada"}",
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              onPressed: () {
                openAdressChooser();
              },
              icon: Icon(Icons.arrow_drop_down),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: Button(
            onPressed: () async {
              final user = await _userController.getCurrentUserFromSession();
              if (user != null) {
                showAddressDialog(context, user);
              }
            },
            text: "Colocar novo endereço",
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Horários",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        RadioListTile<String>(
          contentPadding: const EdgeInsets.all(2),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pedir agora'),
                  Text(
                    'Total: R\$19,90',
                    style: TextStyle(color: Colors.green, fontSize: 12),
                  ),
                ],
              ),
              Text(
                'Previsão de chegada: 12:02',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          value: "Pedir agora",
          groupValue: widget.selected,
          onChanged: (value) {
            setState(() {
              widget.selected = value!;
            });
          },
        ),
        const Divider(),
        RadioListTile<String>(
          contentPadding: const EdgeInsets.all(2),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mais econômico!',
                style: TextStyle(fontSize: 12, color: Color(0xFFFFAA00)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Agendar compra'),
                  InkWell(
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder:
                            (BuildContext context) => AlertDialog(
                              title: const Text('Escolha a data e horário'),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      children: [
                                        const Text("Dia"),
                                        IconButton(
                                          onPressed: () async {
                                            await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.now().add(
                                                const Duration(days: 14),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.date_range,
                                            color: Colors.indigo,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("Hora"),
                                        IconButton(
                                          onPressed: () async {
                                            selectTime(context, 8, 21);
                                          },
                                          icon: const Icon(
                                            Icons.timer,
                                            color: Colors.indigo,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed:
                                      () => Navigator.pop(context, 'Cancelar'),
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Ok'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                      );
                    },
                    child: const Text(
                      "Escolher",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 12,
                        color: Color.fromARGB(255, 13, 63, 112),
                      ),
                    ),
                  ),
                  const Text(
                    'Total: R\$12,90',
                    style: TextStyle(color: Colors.green, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          value: "Agendar compra",
          groupValue: widget.selected,
          onChanged: (value) {
            setState(() {
              widget.selected = value!;
            });
          },
        ),
      ],
    );
  }

  void openAdressChooser() async {
    final selectedAddress = await showModalBottomSheet<Address>(
      context: context,
      builder: (context) {
        return FutureBuilder<List<Address>?>(
          future: getAllAddresses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data!.isEmpty) {
              return const Center(child: Text("Nenhum endereço encontrado"));
            }

            final addresses = snapshot.data!;

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: addresses.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final address = addresses[index];
                return ListTile(
                  leading: const Icon(Icons.home),
                  title: Text("Quadra ${address.quadra}"),
                  subtitle: Text("${address.street}, ${address.city}"),
                  onTap: () {
                    Navigator.pop(context, address);
                  },
                );
              },
            );
          },
        );
      },
    );

    setState(() {
      _address = selectedAddress;
      widget.order.dadosEntrega ??= DeliverData(
        pedidoId: 0,
        tipoVeiculo: "",
        enderecoId: 0,
      );
      widget.order.dadosEntrega!.enderecoId = selectedAddress!.id!;
    });
  }
}
