import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/register-controller.dart';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:projeto_de_sistemas/screens/components/register/button.dart';
import 'package:projeto_de_sistemas/screens/components/register/form_input.dart';
import 'package:projeto_de_sistemas/screens/components/register/register_form.dart';
import 'package:projeto_de_sistemas/screens/components/register/register_top_style.dart';
import 'package:projeto_de_sistemas/screens/form_data_debug.dart';
import 'package:projeto_de_sistemas/utils/consts.dart';
import 'package:projeto_de_sistemas/utils/functions/validation_functions.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key, required this.userType});
  final UserTypes userType;

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser>
    with SingleTickerProviderStateMixin {
  int index = 1;
  List<PlatformFile> files = [
    PlatformFile(name: "", size: 0),
    PlatformFile(name: "", size: 0),
    PlatformFile(name: "", size: 0),
  ];

  final Map<String, TextEditingController> controllers = {
    'completeName': TextEditingController(),
    'cpf': TextEditingController(),
    'nascimento': TextEditingController(),
    'phone': TextEditingController(),
    'email': TextEditingController(),
    'cep': TextEditingController(),
    'street': TextEditingController(),
    'neighbourhood': TextEditingController(),
    'city': TextEditingController(),
    'state': TextEditingController(),
    'usuario': TextEditingController(),
    'password': TextEditingController(),
    'confirmPassword': TextEditingController(),
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

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  final _validationKey = GlobalKey<FormState>();

  final RegisterController registerController = RegisterController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Inicia a animação assim que o widget for exibido
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Limpa o controller quando o widget for destruído
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _validationKey,
        child: Column(
          children: <Widget>[
            RegisterTopStyle(
              text:
                  widget.userType == UserTypes.client
                      ? "Cadastro de cliente"
                      : "Cadastro separador/entregador",
            ),
            Expanded(child: getFormByIndex()),
          ],
        ),
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
                    _controller.reset();
                    _controller.forward(); // Reinicia a animação
                  });
                },
                text: "Voltar",
                color: Colors.deepOrange,
              ),
            if (index <= 6)
              Button(
                /* Avança sem validação (SOMENTE PARA DEBUGGING) */
                onPressed: () {
                  setState(() {
                    if (widget.userType == UserTypes.client && index == 3) {
                      index = 7;
                    } else {
                      index++;
                    }
                    _controller.reset();
                    _controller.forward(); // Reinicia a animação
                  });
                },
                /* Só avança se estiver validado */
                // onPressed: () {
                //   if (index == 6) {
                //     if (files.any(
                //           (file) => file.size == 0 || file.name.isEmpty,
                //         ) &&
                //         widget.userType == UserTypes.worker) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(
                //           content: Text(
                //             'Selecione os documentos necessários para o cadastro',
                //           ),
                //         ),
                //       );
                //       return;
                //     }
                //   }
                //   if (_validationKey.currentState!.validate()) {
                //     setState(() {
                //       if (widget.userType == UserTypes.client && index == 3) {
                //         index = 7;
                //       } else {
                //         index++;
                //       }
                //       _controller.reset();
                //       _controller.forward(); // Reinicia a animação
                //     });
                //   } else {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(
                //         content: Text('Preencha todos os campos!'),
                //       ),
                //     );
                //   }
                // },
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
    return SlideTransition(
      position: _offsetAnimation,
      child: _getFormByIndex(),
    );
  }

  Widget _getFormByIndex() {
    switch (index) {
      case 1:
        return RegisterForm(
          title: "Dados pessoais",
          fields: [
            FormInput(
              label: "Nome Completo",
              controller: controllers['completeName']!,
              placeholder: "Seu nome",
              validator: (value) => validateName(value),
            ),
            FormInput(
              label: "CPF",
              controller: controllers['cpf']!,
              placeholder: "Seu CPF",
              type: TextInputType.number,
              validator: (value) => validateCpf(value),
            ),
            TextFormField(
              controller: controllers['nascimento'],
              readOnly: true,
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  controllers['nascimento']!.text = formatDate(pickedDate);
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Data de nascimento"),
                hintText: "01/01/1999",
              ),
            ),
            FormInput(
              label: "Telefone",
              controller: controllers['phone']!,
              placeholder: "00 00000-0000",
              type: TextInputType.phone,
              validator: (value) => validatePhone(value),
            ),
            FormInput(
              label: "Email",
              controller: controllers['email']!,
              placeholder: "seuemail@email.com",
              type: TextInputType.emailAddress,
              validator: (value) => validateEmail(value),
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
              type: TextInputType.number,
              validator: (value) => validateCep(value),
            ),
            FormInput(
              label: "Rua",
              controller: controllers['street']!,
              placeholder: "Nome da rua",
            ),
            FormInput(
              label: "Bairro",
              controller: controllers['neighbourhood']!,
              placeholder: "Bairro",
            ),
            FormInput(
              label: "Cidade",
              controller: controllers['city']!,
              placeholder: "Palmas",
            ),
            DropdownButtonFormField<String>(
              value: "TO",
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Estado"),
                hintText: "Selecione o estado",
              ),
              items: selectEstadoItens,
              onChanged: (value) {
                controllers['state']?.text = value ?? "";
              },
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
              controller: controllers['password']!,
              placeholder: "*********",
              isPassword: true,
              validator: (value) => validatePassword(value),
            ),
            FormInput(
              label: "Confirmar senha",
              controller: controllers['confirmPassword']!,
              placeholder: "Confirme sua senha",
              validator:
                  (value) => validateConfirmPassword(
                    value,
                    controllers['senha']!.text,
                  ),
              isPassword: true,
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
                validator: (value) => validateCpf(value),
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
                validator: (value) => validateAccount(value),
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
                validator: (value) => validateCarPlate(value),
              ),
              FormInput(
                label: "CNH",
                controller: controllers['cnh']!,
                placeholder: "98765432100",
                type: TextInputType.number,
                validator: (value) => validateCnh(value),
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 36,
        children: [
          Icon(Icons.check_circle_outline, size: 150, color: Colors.green),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text("Está tudo pronto para terminarmos seu cadastro!", textAlign: TextAlign.center, style: TextStyle(
              fontSize: 20,
              color: Colors.green,
              fontWeight: FontWeight.w500
            ),),
          ),
          Button(
            onPressed: () {
              registerController.saveUser(user: mapFormDataToUser());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormDataDebug(user: mapFormDataToUser()),
                ),
              );
            },
            text: "Concluir cadastro",
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  User mapFormDataToUser() {
    User user = User(
      completeName: controllers["completeName"]!.text,
      dateJoined: DateTime.now(),
      email: controllers["email"]!.text,
      firstName: controllers["completeName"]!.text.split(" ")[0],
      lastName: controllers["completeName"]!.text,
      cpf: controllers["cpf"]!.text,
      phone: controllers["phone"]!.text,
      password: controllers["password"]!.text,
      isSuperuser: false,
      isActive: true,
      isStaff: false,
      lastLogin: DateTime.now(),
    );

    return user;
  }
}
