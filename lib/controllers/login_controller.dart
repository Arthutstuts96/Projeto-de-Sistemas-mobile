import 'package:projeto_de_sistemas/controllers/user_controller.dart';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:projeto_de_sistemas/domain/repository/register_user_repository.dart';
import 'package:projeto_de_sistemas/services/api/login_user_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController implements LoginRepository {
  final LoginUserApi _loginUserApi = LoginUserApi();

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

  @override
  Future<Map<String, dynamic>> loginClientUser({
    required String email,
    required String password,
  }) async {
    UserController().saveUserToSession(
      user: User(
        email: email,
        firstName: "Separadilson",
        lastName: 'da Costa e Silva',
        completeName: 'Separadilson da Costa e Silva',
        cpf: '23131231232',
        phone: '',
        password: password,
        isSuperuser: false,
        isActive: true,
        isStaff: false,
        lastLogin: DateTime.now(),
        dateJoined: DateTime.now(),
      ),
    );
    return await _loginUserApi.loginClientUser(
      email: email,
      password: password,
      loginUrl: 'api/token/',
    );
  }

  @override
  Future<Map<String, dynamic>> loginDeliveryUser({
    required String email,
    required String password,
  }) async {
    return {'success': false, 'error': "Erro: Não implementado"};
    // return await _loginUserApi.loginDeliveryUser(email: email, password: password, loginUrl: 'url_do_delivery');
  }

  @override
  Future<Map<String, dynamic>> loginShopperUser({
    required String email,
    required String password,
  }) async {
    return {'success': false, 'error': "Erro: Não implementado"};
    // return await _loginUserApi.loginShopperUser(email: email, password: password, loginUrl: 'url_do_separador');
  }
}
