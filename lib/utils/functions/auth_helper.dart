import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

  static Dio getAuthenticatedDio() {
    final dio = Dio();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // Implementar lógica de refresh token aqui se necessário
            await clearTokens();
            // Navegar para tela de login
          }
          return handler.next(error);
        },
      ),
    );

    return dio;
  }
}
