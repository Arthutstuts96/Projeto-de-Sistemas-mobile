import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';

class FormDataDebug extends StatelessWidget {
  const FormDataDebug({super.key, required this.user});
  final User user;

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
          children: getUserFields(user),
        ),
      ),
    );
  }

  List<Text> getUserFields(User user) {
    Map<String, dynamic> mapUser = user.toMap();

    return mapUser.entries.map((entry) {
      return Text("${entry.key}: ${entry.value}");
    }).toList();
  }
}
