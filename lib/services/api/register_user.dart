import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:dio/dio.dart';
import 'package:projeto_de_sistemas/utils/api_configs.dart';

class RegisterUserApi {
  final Dio dio = Dio();

  Future<bool> saveUser({required User user}) async {
    try {
      print("Começando requisição...");
      final response = await dio.post(
        '$ipHost/api/signup/', 
        data: {
          'first_name': user.firstName,
          'last_name': user.lastName,
          'cpf': user.cpf,
          'phone': user.phone,
          'password': user.password,
          'email': user.email,
        },
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      if (response.statusCode == 201) {
        print("Usuário criado com sucesso: ${response.data}");
        return true;
      } else {
        print("Falha ao criar usuário: Status ${response.statusCode}, Resposta: ${response.data}");
        return false;
      }
    } catch (e) {
      print("Erro ao salvar usuário: $e");
      if (e is DioException) {
        print("Detalhes do erro: ${e.response?.data}");
      }
      return false;
    }
  }

  // Future<bool> saveClient() async {
  //   return false;
  // }

  // Future<bool> saveWorker() async {
  //   return false;
  // }
}
