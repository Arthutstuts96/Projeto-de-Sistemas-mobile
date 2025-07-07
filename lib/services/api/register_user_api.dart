import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:dio/dio.dart';
import 'package:projeto_de_sistemas/utils/api_configs.dart';

class RegisterUserApi {
  final Dio dio = Dio();

  Future<bool> saveUser({required User user, required String postUrl}) async {
    try {
      final response = await dio.post(
        '$ipHost/users/$postUrl',
        data: {
          'user': {'email': user.email, 'password': user.password},
          'first_name': user.firstName,
          'last_name': user.lastName,
          'cpf': user.cpf,
          'phone': user.phone,
        },
        options: Options(contentType: Headers.jsonContentType),
      );
      print(response);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
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
