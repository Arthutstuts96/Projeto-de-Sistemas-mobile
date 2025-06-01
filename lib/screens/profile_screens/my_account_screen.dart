import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key, required this.title, this.user});
  final String title;
  final User? user;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> accountOptions = [
      {
        'title': 'Dados Pessoais',
        'description': 'Visualize seu nome, email e CPF.',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PersonalData(currentUser: user),
            ),
          );
        },
      },
      // Você pode adicionar mais opções abaixo conforme necessário
      // {
      //   'title': 'Segurança',
      //   'description': 'Atualize sua senha e verificação em duas etapas.',
      //   'onTap': () {
      //     Navigator.pushNamed(context, '/security');
      //   },
      // },
      {
        'title': 'Deletar conta',
        'description': 'Apagar sua conta.',
        'onTap': () {
          // Navigator.pushNamed(context, '/security');
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: accountOptions.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final item = accountOptions[index];
          return TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              alignment: Alignment.centerLeft,
            ),
            onPressed: item['onTap'],
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  item['description'],
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PersonalData extends StatelessWidget {
  const PersonalData({super.key, this.currentUser});
  final User? currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dados pessoais")),
      body: Column(
        children: [
          ListTile(
            title: const Text("Nome", style: TextStyle(fontSize: 16)),
            subtitle: Text(
              currentUser!.completeName,
              style: const TextStyle(color: Color.fromARGB(255, 116, 116, 116)),
            ),
          ),
          ListTile(
            title: const Text("CPF", style: TextStyle(fontSize: 16)),
            subtitle: Text(
              currentUser!.cpf,
              style: const TextStyle(color: Color.fromARGB(255, 116, 116, 116)),
            ),
          ),
          ListTile(
            title: const Text("Email", style: TextStyle(fontSize: 16)),
            subtitle: Text(
              currentUser!.email,
              style: const TextStyle(color: Color.fromARGB(255, 116, 116, 116)),
            ),
          ),
          ListTile(
            title: const Text("Telefone", style: TextStyle(fontSize: 16)),
            subtitle: Text(
              currentUser!.phone != "" ? currentUser!.phone : "Não informado",
              style: const TextStyle(color: Color.fromARGB(255, 116, 116, 116)),
            ),
          ),
          ListTile(
            title: const Text("Senha", style: TextStyle(fontSize: 16)),
            subtitle: Text(
              '*' * currentUser!.password.length,
              style: const TextStyle(color: Color.fromARGB(255, 116, 116, 116)),
            ),
          ),
        ],
      ),
    );
  }
}
