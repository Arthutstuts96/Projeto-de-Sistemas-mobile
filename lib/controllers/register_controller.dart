import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:projeto_de_sistemas/domain/repository/register_user_repository.dart';
import 'package:projeto_de_sistemas/services/api/register_user_api.dart';

class RegisterController implements RegisterUserRepository {
  final RegisterUserApi _registerUserApi = RegisterUserApi();

  @override
  Future<bool> saveClientUser({required User user}) async {
    final bool success = await _registerUserApi.saveUser(
      user: user,
      postUrl: 'clients/',
    );
    return success;
  }

  @override
  Future<bool> saveDeliveryUser({required User user}) async {
    final bool success = await _registerUserApi.saveUser(
      user: user,
      postUrl: 'delivery-users/',
    );
    return success;
  }

  @override
  Future<bool> saveShopperUser({required User user}) async {
    final bool success = await _registerUserApi.saveUser(
      user: user,
      postUrl: 'separater-users/',
    );
    return success;
  }
}
