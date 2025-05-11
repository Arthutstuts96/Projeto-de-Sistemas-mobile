import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({super.key, required this.onPressed, required this.text, this.color = Colors.blue});
  final Function onPressed;
  final String text;
  final MaterialColor color;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(widget.color),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      onPressed: (){
        widget.onPressed();
      },
      child: Text(
        widget.text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
