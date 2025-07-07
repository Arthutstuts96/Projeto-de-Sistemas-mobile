import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/register_controller.dart';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:projeto_de_sistemas/screens/components/button.dart';
import 'package:projeto_de_sistemas/screens/components/register/form_input.dart';
import 'package:projeto_de_sistemas/screens/components/register/register_form.dart';
import 'package:projeto_de_sistemas/screens/components/register/register_top_style.dart';
import 'package:projeto_de_sistemas/utils/consts.dart';
import 'package:projeto_de_sistemas/utils/functions/validation_functions.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({super.key, required this.userType});
  final UserTypes userType;

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen>
    with SingleTickerProviderStateMixin {
  int index = 1;
  List<PlatformFile> files = List.generate(
    2,
    (_) => PlatformFile(name: "", size: 0),
  );

  final Map<String, TextEditingController> controllers = {
    'completeName': TextEditingController(),
    'cpf': TextEditingController(),
    'nascimento': TextEditingController(),
    'phone': TextEditingController(),
    'email': TextEditingController(),
    'cep': TextEditingController(),
    'street': TextEditingController(),
    'city': TextEditingController(),
    'state': TextEditingController(),
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

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.cover,
            ),
          ),
          Form(
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
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFfff8d9),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 48),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (index != 1)
                Button(
                  onPressed: () {
                    setState(() {
                      if (widget.userType == UserTypes.client && index == 6) {
                        index = 2;
                      } else {
                        index--;
                      }
                      _controller.reset();
                      _controller.forward();
                    });
                  },
                  text: "Voltar",
                  color: Colors.deepOrange,
                ),
              if (index <= 5)
                Button(
                  onPressed: () {
                    if (index == 5) {
                      if (files.any(
                            (file) => file.size == 0 || file.name.isEmpty,
                          ) &&
                          widget.userType == UserTypes.worker) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Selecione os documentos necessários para o cadastro',
                            ),
                          ),
                        );
                        return;
                      }
                    }
                    if (_validationKey.currentState!.validate()) {
                      setState(() {
                        if (widget.userType == UserTypes.client && index == 2) {
                          index = 6;
                        } else {
                          index++;
                        }
                        _controller.reset();
                        _controller.forward();
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Preencha todos os campos!'),
                        ),
                      );
                    }
                  },
                  text: "Próximo",
                ),
            ],
          ),
        ),
      ),
    );
  }

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
              decoration: const InputDecoration(
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
              // validator: (value) => validatePhone(value),
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
          title: "Dados de login e segurança",
          icon: Icons.password,
          fields: [
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
                    controllers['password']!.text,
                  ),
              isPassword: true,
            ),
          ],
        );
      case 3:
        if (widget.userType == UserTypes.worker) {
          return RegisterForm(
            title: "Dados bancários",
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
      case 4:
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
        break;
      case 5:
        if (widget.userType == UserTypes.worker) {
          return RegisterForm(
            title: "Documentação",
            icon: Icons.folder,
            fields: [
              const SizedBox(height: 4),
              const Text("Foto do RG/CNH", style: TextStyle(fontSize: 16)),
              Button(
                onPressed: () async => pickFile(0),
                text: "Selecione um arquivo",
              ),
              Text(files[0].name),
              const SizedBox(height: 12),
              const Text(
                "Comprovante de residência",
                style: TextStyle(fontSize: 16),
              ),
              Button(
                onPressed: () async => pickFile(1),
                text: "Selecione um arquivo",
              ),
              Text(files[1].name),
              // const SizedBox(height: 12),
              // const Text(
              //   "Foto segurando o documento",
              //   style: TextStyle(fontSize: 16),
              // ),
              // Button(
              //   onPressed: () async => pickFile(2),
              //   text: "Selecione um arquivo",
              // ),
              // Text(files[2].name),
            ],
          );
        }
        break;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 150,
            color: Colors.green,
          ),
          const SizedBox(height: 36),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Está tudo pronto para terminarmos seu cadastro!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Button(
            onPressed: () async {
              final user = mapFormDataToUser();
              final success = await registerController.saveClientUser(
                user: user,
              );
              if (success) {
                Navigator.pushReplacementNamed(context, "login_screen");
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Algo deu errado! Verifique suas informações e tente novamente",
                    ),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }
            },
            text: "Concluir cadastro",
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Future<void> pickFile(int indexFile) async {
    final fileList = await FilePicker.platform.pickFiles();
    if (fileList != null) {
      setState(() {
        files[indexFile] = fileList.files.first;
      });
    }
  }

  User mapFormDataToUser() {
    return User(
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
  }
}
