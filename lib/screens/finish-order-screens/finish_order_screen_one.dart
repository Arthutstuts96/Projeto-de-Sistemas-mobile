import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/domain/models/order/order.dart';
import 'package:projeto_de_sistemas/screens/components/register/button.dart';
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
  String _address = "Endereço não definido";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          "Escolha o endereço de entrega",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Row(
          children: [
            const Icon(Icons.location_on_outlined, size: 24),
            const SizedBox(width: 4),
            Expanded(child: Text(_address, overflow: TextOverflow.ellipsis)),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: Button(
            onPressed: () {
              String tempAddress = _address;
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Alterar endereço"),
                    content: TextFormField(
                      initialValue: tempAddress,
                      onChanged: (value) => tempAddress = value,
                      decoration: const InputDecoration(
                        labelText: "Novo endereço",
                        hintText: "Digite seu novo endereço",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Button(
                        onPressed: () {
                          final newAddress = tempAddress.trim();
                          if (newAddress.isNotEmpty) {
                            setState(() {
                              _address = newAddress;

                              widget.order.enderecoEntrega =
                                  _address;
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        text: "Salvar",
                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                      ),
                    ],
                  );
                },
              );
            },
            text: "Trocar endereço",
          ),
        ),
        SizedBox(height: 16),
        Text(
          "Horários",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        RadioListTile<String>(
          contentPadding: EdgeInsets.all(2),
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
          contentPadding: EdgeInsets.all(2),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mais econômico!',
                style: TextStyle(fontSize: 12, color: Color(0xFFFFAA00)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Agendar compra'),
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
                                        Text("Dia"),
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
                                          icon: Icon(
                                            Icons.date_range,
                                            color: Colors.indigo,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Hora"),
                                        IconButton(
                                          onPressed: () async {
                                            selectTime(context, 8, 21);
                                          },
                                          icon: Icon(
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
                    child: Text(
                      "Escolher",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 12,
                        color: Color.fromARGB(255, 13, 63, 112),
                      ),
                    ),
                  ),
                  Text(
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
}
