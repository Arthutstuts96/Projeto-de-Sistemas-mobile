import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/register_user.dart';
import 'package:projeto_de_sistemas/utils/consts.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Escolha entre cliente ou entregador"),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterUser(userType: UserTypes.client,)),
                );
              },
              child: Text("Cliente"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterUser(userType: UserTypes.worker,)),
                );
              },
              child: Text("Entregador"),
            ),
          ],
        ),
      ),
    );
  }
}