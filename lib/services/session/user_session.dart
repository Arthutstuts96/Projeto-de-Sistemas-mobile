import 'dart:convert';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  static const String _orderKey = 'user';

  // Salva o usuário na sessão
  Future<bool> saveUserToSession(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String userJson = jsonEncode(user.toJson());
      await prefs.setString(_orderKey, userJson);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Recupera o email do usuario da sessão
  Future<User?> getUserFromSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? userJson = prefs.getString(_orderKey);
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
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_orderKey);
      return true;
    } catch (e) {
      return false;
    }
  }
}
