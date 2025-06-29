import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:projeto_de_sistemas/domain/repository/user_repository.dart';
import 'package:projeto_de_sistemas/services/session/user_session.dart';

class UserController implements UserRepository{
  final UserSession _userSession = UserSession();

  @override
  Future<bool> deleteCurrentUserFromSession() async {
    return await _userSession.deleteUserFromSession();
  }

  @override
  Future<User?> getCurrentUserFromSession() async {
    return await _userSession.getUserFromSession();
  }
  
  @override
  Future<bool> saveUserToSession({required User user}) async{
    return await _userSession.saveUserToSession(user);
  }
}