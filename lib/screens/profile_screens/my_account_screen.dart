import 'package:flutter/material.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> accountOptions = [
      {
        'title': 'Dados Pessoais',
        'description': 'Visualize e edite seu nome, email e CPF.',
        'onTap': () {
          // Navigator.pushNamed(context, '/personal_data');
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
                const SizedBox(height: 4),
                Text(
                  item['description'],
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
