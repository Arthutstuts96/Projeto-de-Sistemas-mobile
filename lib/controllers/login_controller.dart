import 'package:projeto_de_sistemas/controllers/user_controller.dart';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:projeto_de_sistemas/domain/repository/register_user_repository.dart';
import 'package:projeto_de_sistemas/services/api/login_user_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController implements LoginRepository {
  final LoginUserApi _loginUserApi = LoginUserApi();

  @override
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    //TODO: Usar o get de usuário e salvá-lo na sessão com seus dados reais
    // CADE O GET USUARIO PELO EMAIL??
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
    return await _loginUserApi.loginUser(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }
}
