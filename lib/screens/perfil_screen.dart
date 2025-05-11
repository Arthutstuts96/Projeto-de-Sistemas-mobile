import 'package:flutter/material.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({Key? key}) : super(key: key);

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Confirmar saída'),
            content: const Text('Tem certeza que deseja sair da conta?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  _logout(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text('Sair'),
              ),
            ],
          ),
    );
  }

  void _logout(BuildContext context) {

    Navigator.of(context).pushReplacementNamed('login_screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => _confirmLogout(context),
              icon: const Icon(Icons.logout),
              label: const Text('Sair'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: const Color.fromARGB(255, 223, 23, 23),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 20), // Espaço entre os botões
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, 'delivery_screen');
              },
              icon: const Icon(Icons.delivery_dining),
              label: const Text('Ir para Delivery Home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
