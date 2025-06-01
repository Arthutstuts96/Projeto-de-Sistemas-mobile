import 'package:projeto_de_sistemas/domain/models/users/user.dart';

abstract class RegisterUserRepository {
    Future<void> saveClientUser({required User user});
}

abstract class LoginRepository {
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  });
  Future<void> logout();
}
