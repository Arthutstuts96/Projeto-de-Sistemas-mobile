import 'package:projeto_de_sistemas/domain/models/users/user.dart';

abstract class RegisterUserRepository {
    Future<bool> saveClientUser({required User user});
    Future<bool> saveDeliveryUser({required User user});
    Future<bool> saveShopperUser({required User user});
}

abstract class LoginRepository {
  Future<Map<String, dynamic>> loginClientUser({
    required String email,
    required String password,
  });
  Future<Map<String, dynamic>> loginShopperUser({
    required String email,
    required String password,
  });
  Future<Map<String, dynamic>> loginDeliveryUser({
    required String email,
    required String password,
  });
  Future<void> logout();
}
