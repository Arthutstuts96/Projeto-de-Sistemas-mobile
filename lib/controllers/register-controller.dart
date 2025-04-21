import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:projeto_de_sistemas/domain/repository/user_repository.dart';

class RegisterController implements UserRepository {
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
  Future<void> saveUser({required User user}) async {
    //TODO: comunicação com a api services para salvar o usuário no banco
    print("Usuário cadastrado com sucesso ${user.toString()}");
  }
}
