import 'package:projeto_de_sistemas/domain/models/users/user.dart';

abstract class UserRepository {
    Future<List<User>> getAllUsers();    
    Future<void> saveUser({required User user});
    Future<void> deleteUser({required User user});
}

abstract class LoginRepository {
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  });
  Future<void> logout();
}
