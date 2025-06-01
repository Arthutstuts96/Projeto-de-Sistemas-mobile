import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/address_controller.dart';
import 'package:projeto_de_sistemas/domain/models/users/address.dart';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:projeto_de_sistemas/screens/components/register/button.dart';
import 'package:projeto_de_sistemas/utils/consts.dart';

Future<bool> showAddressDialog(BuildContext context, User user) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      final cityController = TextEditingController();
      final stateController = TextEditingController(text: "TO");
      final streetController = TextEditingController();
      final numberController = TextEditingController();
      final quadraController = TextEditingController();
      final loteController = TextEditingController();
      final referenceController = TextEditingController();
      final observationController = TextEditingController();

      return AlertDialog(
        title: const Text("Novo Endereço"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: cityController,
                decoration: const InputDecoration(labelText: 'Cidade'),
              ),
              DropdownButtonFormField<String>(
                value: "TO",
                decoration: const InputDecoration(
                  label: Text("Estado"),
                  hintText: "Selecione o estado",
                ),
                items: selectEstadoItens,
                onChanged: (value) {
                  stateController.text = value ?? "";
                },
              ),
              TextField(
                controller: streetController,
                decoration: const InputDecoration(labelText: 'Rua'),
              ),
              TextField(
                controller: numberController,
                decoration: const InputDecoration(labelText: 'Número'),
              ),
              TextField(
                controller: quadraController,
                decoration: const InputDecoration(labelText: 'Quadra'),
              ),
              TextField(
                controller: loteController,
                decoration: const InputDecoration(labelText: 'Lote'),
              ),
              TextField(
                controller: referenceController,
                decoration: const InputDecoration(labelText: 'Referência'),
              ),
              TextField(
                controller: observationController,
                decoration: const InputDecoration(labelText: 'Observação'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              "Cancelar",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          Button(
            onPressed: () async {
              final success = await AddressController().saveAddress(
                address: Address(
                  user: user,
                  city: cityController.text,
                  state: stateController.text,
                  street: streetController.text,
                  number: numberController.text,
                  quadra: quadraController.text,
                  lote: loteController.text,
                  reference: referenceController.text,
                  observation: observationController.text,
                ),
              );

              Navigator.pop(context, success); // <-- Retorna o resultado

              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(
                      "Cadastrado com sucesso",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      "Não foi possível cadastrar o endereço. Verifique as informações e tente novamente",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            },
            text: "Salvar",
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          ),
        ],
      );
    },
  );
  return result == true;
}
