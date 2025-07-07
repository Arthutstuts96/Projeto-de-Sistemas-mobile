import 'dart:convert';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:projeto_de_sistemas/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  static const String _orderKey = 'user';
  final SharedPreferences _prefs;

  UserSession() : _prefs = getIt<SharedPreferences>();
  UserSession.testable({required SharedPreferences prefs}) : _prefs = prefs;

  // Salva o usuário na sessão
  Future<bool> saveUserToSession(User user) async {
    try {
      final String userJson = jsonEncode(user.toJson());
      await _prefs.setString(_orderKey, userJson);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Recupera o email do usuario da sessão
  Future<User?> getUserFromSession() async {
    try {
      final String? userJson = _prefs.getString(_orderKey);
      if (userJson != null) {
        return User.fromJson(jsonDecode(userJson));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Remove o email do usuario da sessão
  Future<bool> deleteUserFromSession() async {
    try {
      await _prefs.remove(_orderKey);
      return true;
    } catch (e) {
      return false;
    }
  }
}
