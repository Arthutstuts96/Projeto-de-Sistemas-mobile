import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projeto_de_sistemas/utils/api_configs.dart';

class LoginController {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // Fazer requisição para a API
      final response = await _dio.post(
        '$ipHost/api/token/', // Rota do Django REST JWT
        data: {'email': email, 'password': password},
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      // Processar resposta
      if (response.statusCode == 200) {
        final tokens = response.data;

        // 3. Armazenar tokens localmente
        await _storeTokens(tokens['access'], tokens['refresh']);

        return {'success': true, 'tokens': tokens};
      }

      return {
        'success': false,
        'error': 'Credenciais inválidas ou servidor indisponível',
      };
    } on DioException catch (e) {
      // Tratamento específico para erros de rede/Dio
      String errorMessage = 'Erro na conexão(Dio)';
      if (e.response?.statusCode == 401) {
        errorMessage = 'Email ou senha incorretos';
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Tempo de conexão esgotado';
      }

      return {'success': false, 'error': errorMessage};
    } catch (e) {
      return {'success': false, 'error': 'Erro desconhecido: ${e.toString()}'};
    }
  }

  // Armazenar tokens e Mantem o usuário logado
  Future<void> _storeTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
  }
}
