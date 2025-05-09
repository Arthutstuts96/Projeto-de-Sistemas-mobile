import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/components/products/change_quantity_button.dart';

class CartProduct extends StatelessWidget {
  const CartProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key("Asas"),
      direction: DismissDirection.endToStart,
      background: Container(
        width: 20,
        color: Colors.red,
        child: Icon(Icons.cancel, size: 50),
      ),
      child: Column(
        children: [
          Container(
            height: 124,
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      Container(width: 140, height: 100, color: Colors.amber),
                      RichText(
                        text: TextSpan(
                          text: 'Caixa de ovos\n',
                          style: TextStyle(fontSize: 16),
                          children: const <TextSpan>[
                            TextSpan(
                              text: 'R\$23,48',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ChangeQuantityButton(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 10,
            thickness: 2,
            indent: 20,
            endIndent: 0,
            color: Color(0xFFc3c3c3),
          ),
        ],
      ),
    );
  }
}
