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
  List<PlatformFile> files = [
    PlatformFile(name: "", size: 0),
    PlatformFile(name: "", size: 0),
    PlatformFile(name: "", size: 0),
  ];

  final Map<String, TextEditingController> controllers = {
    'nome': TextEditingController(),
    'cpf': TextEditingController(),
    'nascimento': TextEditingController(),
    'telefone': TextEditingController(),
    'email': TextEditingController(),
    'cep': TextEditingController(),
    'rua': TextEditingController(),
    'bairro': TextEditingController(),
    'cidade': TextEditingController(),
    'estado': TextEditingController(),
    'usuario': TextEditingController(),
    'senha': TextEditingController(),
    'confirmarSenha': TextEditingController(),
    'titular': TextEditingController(),
    'cpfTitular': TextEditingController(),
    'banco': TextEditingController(),
    'agencia': TextEditingController(),
    'conta': TextEditingController(),
    'pix': TextEditingController(),
    'veiculo': TextEditingController(),
    'placa': TextEditingController(),
    'cnh': TextEditingController(),
  };

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
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 48),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (index != 1)
              Button(
                onPressed: () {
                  setState(() {
                    if (widget.userType == UserTypes.client && index == 7) {
                      index = 3;
                    } else {
                      index--;
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
                    if (widget.userType == UserTypes.client && index == 3) {
                      index = 7;
                    } else {
                      index++;
                    }
                  });
                },
                text: "Próximo",
              ),
          ],
        ),
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
            FormInput(
              label: "Nome",
              controller: controllers['nome']!,
              placeholder: "Seu nome",
            ),
            FormInput(
              label: "CPF",
              controller: controllers['cpf']!,
              placeholder: "Seu CPF",
            ),
            FormInput(
              label: "Data de nascimento",
              controller: controllers['nascimento']!,
              placeholder: "01/01/2000",
              type: TextInputType.datetime,
            ),
            FormInput(
              label: "Telefone",
              controller: controllers['telefone']!,
              placeholder: "00 00000-0000",
              type: TextInputType.phone,
            ),
            FormInput(
              label: "Email",
              controller: controllers['email']!,
              placeholder: "seuemail@email.com",
              type: TextInputType.emailAddress,
            ),
          ],
        );
      case 2:
        return RegisterForm(
          title: "Endereço",
          icon: Icons.house,
          fields: [
            FormInput(
              label: "CEP",
              controller: controllers['cep']!,
              placeholder: "00000-000",
            ),
            FormInput(
              label: "Rua",
              controller: controllers['rua']!,
              placeholder: "Nome da rua",
            ),
            FormInput(
              label: "Bairro",
              controller: controllers['bairro']!,
              placeholder: "Bairro",
            ),
            FormInput(
              label: "Cidade",
              controller: controllers['cidade']!,
              placeholder: "Palmas",
            ),
            FormInput(
              label: "Estado",
              controller: controllers['estado']!,
              placeholder: "Tocantins",
            ),
          ],
        );
      case 3:
        return RegisterForm(
          title: "Dados de login e segurança",
          icon: Icons.password,
          fields: [
            FormInput(
              label: "Usuário(apelido)",
              controller: controllers['usuario']!,
              placeholder: "João Silva",
            ),
            FormInput(
              label: "Senha",
              controller: controllers['senha']!,
              placeholder: "*********",
            ),
            FormInput(
              label: "Confirmar senha",
              controller: controllers['confirmarSenha']!,
              placeholder: "Confirme sua senha",
            ),
          ],
        );
      case 4:
        if (widget.userType == UserTypes.worker) {
          return RegisterForm(
            title: "Dados de conta bancária",
            icon: Icons.credit_card,
            fields: [
              FormInput(
                label: "Nome do titular",
                controller: controllers['titular']!,
                placeholder: "João da Silva",
              ),
              FormInput(
                label: "CPF do titular",
                controller: controllers['cpfTitular']!,
                placeholder: "123.456.789-00",
              ),
              FormInput(
                label: "Banco",
                controller: controllers['banco']!,
                placeholder: "Banco do Brasil",
              ),
              FormInput(
                label: "Agência",
                controller: controllers['agencia']!,
                placeholder: "1234",
              ),
              FormInput(
                label: "Conta",
                controller: controllers['conta']!,
                placeholder: "56789-0",
              ),
              FormInput(
                label: "Chave Pix",
                controller: controllers['pix']!,
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
            icon: Icons.car_repair,
            fields: [
              FormInput(
                label: "Tipo de veículo",
                controller: controllers['veiculo']!,
                placeholder: "Carro, moto...",
              ),
              FormInput(
                label: "Placa",
                controller: controllers['placa']!,
                placeholder: "AAA-1234",
              ),
              FormInput(
                label: "CNH",
                controller: controllers['cnh']!,
                placeholder: "98765432100",
              ),
            ],
          );
        }
      case 6:
        if (widget.userType == UserTypes.worker) {
          return RegisterForm(
            title: "Documentação",
            icon: Icons.folder,
            fields: [
              SizedBox(height: 4),
              Text("Foto do RG/CNH", style: TextStyle(fontSize: 16)),
              Button(
                onPressed: () async {
                  final fileList = await FilePicker.platform.pickFiles();
                  if (fileList == null) return;
                  final file = fileList.files.first;

                  setState(() {
                    files[0] = file;
                  });
                },
                text: "Selecione um arquivo",
              ),
              Text(files[0].name),
              Text("Comprovante de residência", style: TextStyle(fontSize: 16)),
              Button(
                onPressed: () async {
                  final fileList = await FilePicker.platform.pickFiles();
                  if (fileList == null) return;
                  final file = fileList.files.first;

                  setState(() {
                    files[1] = file;
                  });
                },
                text: "Selecione um arquivo",
              ),
              Text(files[1].name),
              Text(
                "Foto segurando o documento",
                style: TextStyle(fontSize: 16),
              ),
              Button(
                onPressed: () async {
                  final fileList = await FilePicker.platform.pickFiles();
                  if (fileList == null) return;
                  final file = fileList.files.first;

                  setState(() {
                    files[2] = file;
                  });
                },
                text: "Selecione um arquivo",
              ),
              Text(files[2].name),
            ],
          );
        }
        break;
    }

    return Center(
      child: Column(
        children: [
          Button(
            onPressed: () {},
            text: "Cadastro concluído",
            color: Colors.green,
          ),
          Text("${files.map((file) => file.name)}"),
          ...mapFormData(),
        ],
      ),
    );
  }

  List<Text> mapFormData() {
    List<Text> list =
        controllers.entries.map((entry) {
          return Text("${entry.key}: ${entry.value.text}");
        }).toList();
    return list;
  }
}
