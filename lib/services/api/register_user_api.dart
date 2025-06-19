import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:dio/dio.dart';
import 'package:projeto_de_sistemas/utils/api_configs.dart';

class RegisterUserApi {
  final Dio _dio;

  RegisterUserApi() : _dio = Dio();
  // Construtor usado para mockar testes
  RegisterUserApi.testable({required Dio dio}) : _dio = dio;

  Future<bool> saveUser({required User user}) async {
    try {
      final response = await _dio.post(
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
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  //TODO: implementar cadastros para os outros tipos de usuário
  // Future<bool> saveClient() async {
  //   return false;
  // }

  // Future<bool> saveWorker() async {
  //   return false;
  // }
}
