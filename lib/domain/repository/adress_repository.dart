import 'package:projeto_de_sistemas/domain/models/users/address.dart';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';

abstract class AdressRepository {
  Future<List<Address>> getAllAddressesByUserEmail({required User user});
  Future<bool> saveAddress({required Address address});
}