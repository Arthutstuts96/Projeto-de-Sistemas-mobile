import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/components/register/form_input.dart';
import 'package:projeto_de_sistemas/screens/components/register/register_form.dart';
import 'package:projeto_de_sistemas/screens/components/register/register_top_style.dart';

class RegisterClient extends StatelessWidget {
  RegisterClient({super.key});
  final List<FormInput> fieldsPageOne = [
    FormInput(label: "Nome", placeholder: "Arthur lima", type: "text"),
    FormInput(label: "CPF", placeholder: "Arthur lima", type: "text"),
    FormInput(label: "Data de nascimento", placeholder: "Arthur lima", type: "text"),
    FormInput(label: "Telefone", placeholder: "Arthur lima", type: "text"),
    FormInput(label: "Email", placeholder: "Arthur lima", type: "text"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          RegisterTopStyle(
            circleText: "Cadastro de cliente",
            circleColor: Color(0xFF28E3BD),
          ),
          RegisterForm(title: "Dados pessoais", fields: fieldsPageOne,
          ),
        ],
      ),
    );
  }
}
