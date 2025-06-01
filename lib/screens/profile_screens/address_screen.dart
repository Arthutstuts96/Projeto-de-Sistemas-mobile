import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/address_controller.dart';
import 'package:projeto_de_sistemas/domain/models/users/address.dart';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:projeto_de_sistemas/screens/components/register/button.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, required this.title, required this.user});
  final User user;
  final String title;

  @override
  State<AddressScreen> createState() => _AdressScreenState();
}

class _AdressScreenState extends State<AddressScreen> {
  final AddressController _addressController = AddressController();
  late Future<List<Address>> addressListFuture;

  @override
  void initState() {
    super.initState();
    addressListFuture = _addressController.getAllAddressesByUserEmail(
      user: widget.user,
    );
  }

  Future<void> refreshAddresses() async {
    setState(() {
      addressListFuture = _addressController.getAllAddressesByUserEmail(
        user: widget.user,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: RefreshIndicator(
        onRefresh: refreshAddresses,
        child: FutureBuilder<List<Address>>(
          future: addressListFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhum endereço encontrado.'));
            } else {
              final addresses = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final address = addresses[index];
                  return ListTile(
                    title: Text(address.street),
                    subtitle: Text('${address.city} - ${address.state}'),
                    leading: const Icon(Icons.location_on),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: Button(
        onPressed: () async {
          final bool response = await _addressController.saveAddress(
            address: Address(
              user: widget.user,
              city: "city",
              state: "state",
              street: "street",
              number: "number",
              neighborhood: "neighborhood",
              quadra: "quadra",
              lote: "lote",
              reference: "reference",
              observation: "observation",
            ),
          );
          if (response) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("cadastrado com sucesso")));
          } else {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("O cadastro deu errado. Por favor, tente novamente")));
          }
        },
        text: "Cadastrar novo endereço",
      ),
    );
  }
}
