import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/address_controller.dart';
import 'package:projeto_de_sistemas/domain/models/users/address.dart';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:projeto_de_sistemas/utils/widgets/address_dialog.dart';

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
    final newList = await _addressController.getAllAddressesByUserEmail(
      user: widget.user,
    );
    setState(() {
      addressListFuture = Future.value(newList);
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
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFFFAA00)),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Não foi possível buscar os endereços. Tente novamente mais tarde'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhum endereço encontrado.'));
            } else {
              final addresses = snapshot.data!;
              return ListView.builder(
                key: UniqueKey(),
                padding: const EdgeInsets.all(16),
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final address = addresses[index];
                  return ListTile(
                    title: Text(
                      "Quadra ${address.neighborhood}, Lote ${address.street}",
                    ),
                    subtitle: Text(
                      '${address.city} - ${address.state}\n${address.street}',
                    ),
                    leading: const Icon(Icons.location_on),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final success = await showAddressDialog(context, widget.user);
          if (success) {
            await refreshAddresses();
          }
        },
        backgroundColor: Colors.blue,
        label: const Text(
          "Cadastrar novo endereço",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.add_location_alt, color: Colors.white),
      ),
    );
  }
}
