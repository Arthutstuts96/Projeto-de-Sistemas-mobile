import 'package:flutter/material.dart';

enum UserTypes { client, worker }

const selectEstadoItens = [
  DropdownMenuItem<String>(value: "AC", child: Text("Acre")),
  DropdownMenuItem<String>(value: "AL", child: Text("Alagoas")),
  DropdownMenuItem<String>(value: "AP", child: Text("Amapá")),
  DropdownMenuItem<String>(value: "AM", child: Text("Amazonas")),
  DropdownMenuItem<String>(value: "BA", child: Text("Bahia")),
  DropdownMenuItem<String>(value: "CE", child: Text("Ceará")),
  DropdownMenuItem<String>(value: "DF", child: Text("Distrito Federal")),
  DropdownMenuItem<String>(value: "ES", child: Text("Espírito Santo")),
  DropdownMenuItem<String>(value: "GO", child: Text("Goiânia")),
  DropdownMenuItem<String>(value: "MA", child: Text("Maranhão")),
  DropdownMenuItem<String>(value: "MT", child: Text("Mato Grosso")),
  DropdownMenuItem<String>(value: "MS", child: Text("Mato Grosso do Sul")),
  DropdownMenuItem<String>(value: "MG", child: Text("Minas Gerais")),
  DropdownMenuItem<String>(value: "PA", child: Text("Pará")),
  DropdownMenuItem<String>(value: "PB", child: Text("Paraíba")),
  DropdownMenuItem<String>(value: "PR", child: Text("Paraná")),
  DropdownMenuItem<String>(value: "PE", child: Text("Pernambuco")),
  DropdownMenuItem<String>(value: "PI", child: Text("Piauí")),
  DropdownMenuItem<String>(value: "RJ", child: Text("Rio de Janeiro")),
  DropdownMenuItem<String>(value: "RN", child: Text("Rio Grande do Norte")),
  DropdownMenuItem<String>(value: "RS", child: Text("Rio Grande do Sul")),
  DropdownMenuItem<String>(value: "RO", child: Text("Rondônia")),
  DropdownMenuItem<String>(value: "RR", child: Text("Roraima")),
  DropdownMenuItem<String>(value: "SC", child: Text("Santa Catarina")),
  DropdownMenuItem<String>(value: "SP", child: Text("São Paulo")),
  DropdownMenuItem<String>(value: "SE", child: Text("Sergipe")),
  DropdownMenuItem<String>(value: "TO", child: Text("Tocantins")),
];
