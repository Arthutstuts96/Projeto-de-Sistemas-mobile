import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/address_controller.dart';
import 'package:projeto_de_sistemas/domain/models/users/address.dart';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:projeto_de_sistemas/screens/components/button.dart';
import 'package:projeto_de_sistemas/utils/consts.dart';

Future<bool> showAddressDialog(BuildContext context, User user) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      final zipCodeController = TextEditingController();
      final streetController = TextEditingController();
      final numberController = TextEditingController();
      final complementController = TextEditingController();
      final neighborhoodController = TextEditingController();
      final cityController = TextEditingController();
      final stateController = TextEditingController(text: "TO");

      return AlertDialog(
        title: const Text("Novo Endereço"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: zipCodeController,
                decoration: const InputDecoration(labelText: 'CEP'),
                keyboardType: TextInputType.number,
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
                controller: complementController,
                decoration: const InputDecoration(labelText: 'Complemento'),
              ),
              TextField(
                controller: neighborhoodController,
                decoration: const InputDecoration(labelText: 'Bairro'),
              ),
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
                  user: user.id ?? 1,
                  zip_code: zipCodeController.text,
                  street: streetController.text,
                  number: numberController.text,
                  complement: complementController.text,
                  neighborhood: neighborhoodController.text,
                  city: cityController.text,
                  state: stateController.text,
                ),
              );

              Navigator.pop(context, success);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: success ? Colors.green : Colors.red,
                  content: Text(
                    success
                        ? "Cadastrado com sucesso"
                        : "Não foi possível cadastrar o endereço. Verifique as informações e tente novamente",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
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
