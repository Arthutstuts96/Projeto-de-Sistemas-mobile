import 'package:dio/dio.dart';
import 'package:projeto_de_sistemas/utils/api_configs.dart';

class LoginUserApi {
  final Dio dio = Dio();

  Future<Map<String, dynamic>?> authenticate({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '$ipHost/api/token/',
        data: {
          'username':
              email, // Note que o Django espera 'username' mesmo para email
          'password': password,
        },
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        return {
          'access': response.data['access'],
          'refresh': response.data['refresh'],
        };
      }
      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Credenciais inválidas');
      }
      throw Exception('Erro na conexão: ${e.message}');
    }
  }
}
