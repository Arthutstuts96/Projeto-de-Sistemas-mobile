import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/screens/components/register/button.dart';
import 'package:projeto_de_sistemas/screens/components/register/form_input.dart';
import 'package:projeto_de_sistemas/screens/components/register/register_form.dart';
import 'package:projeto_de_sistemas/screens/components/register/register_top_style.dart';
import 'package:projeto_de_sistemas/utils/consts.dart';

class RegisterClient extends StatefulWidget {
  const RegisterClient({super.key, required this.userType});
  final UserTypes userType;

  @override
  State<RegisterClient> createState() => _RegisterClientState();
}

class _RegisterClientState extends State<RegisterClient> {
  int index = 1;
  List<String> nameDebug = ["", "", ""];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          RegisterTopStyle(
            circleText:
                widget.userType == UserTypes.client
                    ? "Cadastro de cliente"
                    : "Cadastro separador/entregador",
            circleColor: Color(0xFF28E3BD),
          ),
          Expanded(child: getFormByIndex()),
          Padding(
            padding: const EdgeInsets.all(36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (index != 1)
                  Button(
                    onPressed: () {
                      setState(() {
                        if (index > 0) {
                          if (widget.userType == UserTypes.client &&
                              index == 7) {
                            index = 3;
                          } else {
                            index--;
                          }
                        }
                      });
                    },
                    text: "Voltar",
                    color: Colors.deepOrange,
                  ),
                if (index <= 6)
                  Button(
                    onPressed: () {
                      setState(() {
                        if (index < 9) {
                          if (widget.userType == UserTypes.client &&
                              index == 3) {
                            index = 7;
                          } else {
                            index++;
                          }
                        }
                      });
                    },
                    text: "Próximo",
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  /*
     Métodos para tratar com os dados do formulário
  */

  Widget getFormByIndex() {
    switch (index) {
      case 1:
        return RegisterForm(
          title: "Dados pessoais",
          fields: [
            FormInput(label: "Nome", placeholder: "Seu nome"),
            FormInput(label: "CPF", placeholder: "Seu CPF"),
            FormInput(
              label: "Data de nascimento",
              placeholder: "01/01/2000",
              type: TextInputType.datetime,
            ),
            FormInput(
              label: "Telefone",
              placeholder: "00 00000-0000",
              type: TextInputType.phone,
            ),
            FormInput(
              label: "Email",
              placeholder: "seuemail@email.com",
              type: TextInputType.emailAddress,
            ),
          ],
        );
      case 2:
        return RegisterForm(
          title: "Endereço",
          fields: [
            FormInput(label: "CEP", placeholder: "00000-000"),
            FormInput(label: "Rua", placeholder: "Nome da rua"),
            FormInput(label: "Bairro", placeholder: "Bairro"),
            FormInput(label: "Cidade", placeholder: "Palmas"),
            FormInput(label: "Estado", placeholder: "Tocantins"),
          ],
        );
      case 3:
        return RegisterForm(
          title: "Dados de login e segurança",
          fields: [
            FormInput(label: "Usuário(apelido)", placeholder: "João Silva"),
            FormInput(label: "Senha", placeholder: "*********"),
            FormInput(
              label: "Confirmar senha",
              placeholder: "Confirme sua senha",
            ),
          ],
        );
      case 4:
        if (widget.userType == UserTypes.worker) {
          return RegisterForm(
            title: "Dados de conta bancária",
            fields: [
              FormInput(label: "Nome do titular", placeholder: "João da Silva"),
              FormInput(label: "CPF do titular", placeholder: "123.456.789-00"),
              FormInput(label: "Banco", placeholder: "Banco do Brasil"),
              FormInput(label: "Agência", placeholder: "1234"),
              FormInput(label: "Conta", placeholder: "56789-0"),
              FormInput(
                label: "Chave Pix",
                placeholder: "joaodasilva@email.com",
              ),
            ],
          );
        }
        break;
      case 5:
        if (widget.userType == UserTypes.worker) {
          return RegisterForm(
            title: "Informações do veículo",
            fields: [
              FormInput(
                label: "Tipo de veículo",
                placeholder: "Carro, moto...",
              ),
              FormInput(label: "Placa", placeholder: "AAA-1234"),
              FormInput(label: "CNH", placeholder: "98765432100"),
            ],
          );
        }
        break;
      case 6:
        if (widget.userType == UserTypes.worker) {
          return RegisterForm(
            title: "Documentação",
            fields: [
              SizedBox(height: 32),
              Text("Foto do RG/CNH"),
              Button(
                onPressed: () async {
                  final fileList = await FilePicker.platform.pickFiles();
                  if (fileList == null) return;
                  final file = fileList.files.first;

                  setState(() {
                    nameDebug[0] = file.name;
                  });
                },
                text: "Selecione um arquivo",
              ),
              Text(nameDebug[0]),
              Text("Comprovante de residência"),
              Button(
                onPressed: () async {
                  final fileList = await FilePicker.platform.pickFiles();
                  if (fileList == null) return;
                  final file = fileList.files.first;

                  setState(() {
                    nameDebug[1] = file.name;
                  });
                },
                text: "Selecione um arquivo",
              ),
              Text(nameDebug[1]),
              Text("Foto segurando o documento"),
              Button(
                onPressed: () async {
                  final fileList = await FilePicker.platform.pickFiles();
                  if (fileList == null) return;
                  final file = fileList.files.first;

                  setState(() {
                    nameDebug[2] = file.name;
                  });
                },
                text: "Selecione um arquivo",
              ),
              Text(nameDebug[2]),
            ],
          );
        }
        break;
    }

    return Center(child: Button(onPressed: (){}, text: "Cadastro concluído", color: Colors.green,));
  }
}
