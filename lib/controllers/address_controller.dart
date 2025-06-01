import 'package:projeto_de_sistemas/domain/models/users/address.dart';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:projeto_de_sistemas/domain/repository/adress_repository.dart';
import 'package:projeto_de_sistemas/services/api/address_api.dart';

class AddressController implements AdressRepository {
  final AddressApi _addressApi = AddressApi();

  @override
  Future<List<Address>> getAllAddressesByUserEmail({required User user}) async {
    final addressList = await _addressApi.getAllAdresses();
    return addressList
        .where((element) => element.user.email == user.email)
        .toList();
  }
  
  @override
  Future<bool> saveAddress({required Address address}) {
    return _addressApi.saveAddress(address: address);
  }
}
