import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/components/register/button.dart';
import 'package:projeto_de_sistemas/utils/functions/select_time.dart';

// ignore: must_be_immutable
class FinishOrderScreenOne extends StatefulWidget {
  FinishOrderScreenOne({super.key, required this.selected});
  String selected;

  @override
  State<FinishOrderScreenOne> createState() => _FinishOrderScreenOneState();
}

class _FinishOrderScreenOneState extends State<FinishOrderScreenOne> {
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
          spacing: 4,
          children: [
            Icon(Icons.location_on_outlined, size: 24),
            Text("Plano Diretor Sul, Quadra 432, 26 de Lote"),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: Button(onPressed: () {}, text: "Trocar endereço"),
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
                                          icon: Icon(Icons.date_range, color: Colors.indigo,),
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
                                          icon: Icon(Icons.timer, color: Colors.indigo,),
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
