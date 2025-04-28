import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:projeto_de_sistemas/domain/repository/user_repository.dart';
import 'package:projeto_de_sistemas/services/api/register_user.dart';

class RegisterController implements UserRepository {
  final RegisterUserApi _registerUserApi = RegisterUserApi();

  @override
  Future<void> deleteUser({required User user}) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<bool> saveUser({required User user}) async {
    final bool success = await _registerUserApi.saveUser(user: user);
    return success;
  }
}
 