import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pix_flutter/pix_flutter.dart';

void showPixDialog(BuildContext context) async {
  PixFlutter pixFlutter = PixFlutter(
    payload: Payload(
      pixKey: 'SUA_CHAVE_PIX',
      description: 'Compra de produtos',
      merchantName: 'Nome do Estabelecimento',
      merchantCity: 'SAOPAULO',
      txid: 'TX123456789',
      amount: "12.23",
    ),
  );

  final String qrCode = pixFlutter.getQRCode(); // Código para copiar

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Pagamento via Pix"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            SelectableText(
              qrCode,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: qrCode));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Código Pix copiado!")),
                );
              },
              icon: Icon(Icons.copy, color: Colors.white),
              label: Text(
                "Copiar código Pix",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Fechar"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}
