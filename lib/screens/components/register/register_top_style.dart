import 'package:flutter/material.dart';

class RegisterTopStyle extends StatelessWidget {
  RegisterTopStyle({super.key, required this.circleText, required this.circleColor});
  final String circleText;
  final Color circleColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 250,
          decoration: BoxDecoration(
            color: circleColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(200),
              bottomRight: Radius.circular(200),
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 64),
          child: Text(
            circleText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.only(top: 56)),
          ),
          child: Icon(
            Icons.subdirectory_arrow_left_rounded,
            size: 36,
            color: Color.fromARGB(255, 44, 44, 44),
          ),
        ),
      ],
    );
  }
}
