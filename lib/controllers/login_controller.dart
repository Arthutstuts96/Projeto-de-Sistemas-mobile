import 'package:projeto_de_sistemas/domain/repository/user_repository.dart';
import 'package:projeto_de_sistemas/services/api/login_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController implements LoginRepository {
  final LoginUserApi _loginUserApi = LoginUserApi();

  @override
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    return await _loginUserApi.loginUser(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }
}
