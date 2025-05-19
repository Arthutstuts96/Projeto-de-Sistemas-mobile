import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/components/register/button.dart';

// ignore: must_be_immutable
class FinishOrderScreenFour extends StatefulWidget {
  FinishOrderScreenFour({super.key});

  @override
  State<FinishOrderScreenFour> createState() => _FinishOrderScreenFourState();
}

class _FinishOrderScreenFourState extends State<FinishOrderScreenFour> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        const Text(
          "Deixe aqui alguma sugestão para o separador:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Container(
          height: 200, 
          child: TextFormField(
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
        ),
        // const Spacer(),
        Align(
          alignment: Alignment.centerRight,
          child: Button(
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Pedido enviado!')));
            },
            text: "Enviar pedido",
            color: Color(0xFFFFAA00),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          ),
        ),
      ],
    );
  }
}
