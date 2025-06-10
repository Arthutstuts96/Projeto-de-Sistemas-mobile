import 'package:projeto_de_sistemas/domain/models/users/address.dart';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:projeto_de_sistemas/domain/repository/adress_repository.dart';
import 'package:projeto_de_sistemas/services/api/address_api.dart';

class AddressController implements AdressRepository {
  final AddressApi _addressApi = AddressApi();

  @override
  Future<List<Address>> getAllAddressesByUserEmail({required User user}) async {
    return await _addressApi.getAllAdressesByUserEmail();
  }
  
  @override
  Future<bool> saveAddress({required Address address}) {
    return _addressApi.saveAddress(address: address);
  }
}
