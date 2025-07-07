import 'package:projeto_de_sistemas/domain/models/users/user.dart';

abstract class UserRepository {
  Future<bool> saveUserToSession({required User user});
  Future<User?> getCurrentUserFromSession();
  Future<bool> deleteCurrentUserFromSession();
}
