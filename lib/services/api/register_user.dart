import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:dio/dio.dart';
import 'package:projeto_de_sistemas/utils/api_configs.dart';

class RegisterUserApi {
  final Dio dio = Dio();

  Future<bool> saveUser({required User user}) async {
    try {
      final response = await Dio().post(
        '$ipHost/signup/',
        data: {
          'first_name': user.firstName,
          'last_name': user.lastName,
          'cpf': user.cpf,
          'phone': user.phone,
          'password': user.password,
          'email': user.email,
        },
        options: Options(
          contentType:
              Headers
                  .formUrlEncodedContentType, 
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
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
