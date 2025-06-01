import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final helpItems = [
      {
        'title': 'Como funciona o app?',
        'content':
            'Nosso app conecta você a mercados próximos. Você faz o pedido e um separador coleta os itens para entrega.',
      },
      {
        'title': 'Como escolher meu pedido?',
        'content':
            'No menu principal, você pode acessar ao catálogo de itens de diversos mercados diferentes. Basta escolher os itens e colocá-los no carrinho, apertando o ícone de bolsa que eles, ou em "Adicionar" na tela do item.',
      },
      {
        'title': 'Como acompanhar meu pedido?',
        'content':
            'Após o pedido ser aceito, você pode acompanhar o status em tempo real na aba "Meus Pedidos".',
      },
      {
        'title': 'Como editar meu endereço?',
        'content':
            'Você pode editar ou adicionar novos endereços acessando o menu "Endereços" no perfil.',
      },
      {
        'title': 'Como alterar a forma de pagamento?',
        'content':
            'Na aba "Meus Cartões" você pode adicionar ou remover métodos de pagamento.',
      },
      {
        'title': 'Como cancelar um pedido?',
        'content':
            'Pedidos podem ser cancelados antes da separação. Vá em "Meus Pedidos", selecione o motivo do cancelamento e confirme. Dependendo do estado que o pedido esteja, o valor dos itens pode até ser reembolsado, mas as taxas de serviço do entregador e do separador serão descontadas.',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemCount: helpItems.length,
        itemBuilder: (context, index) {
          final item = helpItems[index];
          return ExpansionTile(
            backgroundColor: const Color.fromARGB(255, 245, 245, 245),
            tilePadding: const EdgeInsets.symmetric(horizontal: 16),
            title: Text(
              item['title']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(item['content']!),
              ),
            ],
          );
        },
      ),
    );
  }
}
