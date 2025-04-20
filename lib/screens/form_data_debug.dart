import 'package:flutter/material.dart';

class FormDataDebug extends StatelessWidget {
  const FormDataDebug({super.key, required this.formData});
  final List<Text> formData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.only(top: 56)),
              ),
              child: Icon(
                Icons.subdirectory_arrow_left_rounded,
                size: 28,
                color: Color.fromARGB(255, 44, 44, 44),
              ),
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: formData,
        ),
      ),
    );
  }
}