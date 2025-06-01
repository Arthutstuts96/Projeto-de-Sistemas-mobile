import 'package:dio/dio.dart';
import 'package:projeto_de_sistemas/domain/models/users/address.dart';
import 'package:projeto_de_sistemas/utils/api_configs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressApi {
  final Dio _dio = Dio();

  Future<List<Address>> getAllAdresses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        throw Exception('Token não encontrado. Usuário não autenticado.');
      }

      final response = await _dio.get(
        '$ipHost/users/addresses/get/all',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map<Address>((json) => Address.fromMap(json)).toList();
      } else {
        throw Exception('Erro ao buscar endereços: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Sessão expirada. Faça login novamente.');
      }
      throw Exception('Erro ao buscar endereços: ${e.message}');
    } catch (e) {
      throw Exception('Erro ao buscar endereços: $e');
    }
  }

  Future<bool> saveAddress({required Address address}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        throw Exception('Token não encontrado. Usuário não autenticado.');
      }
      final body = {
        'user_email': address.user?.email,
        'city': address.city,
        'state': address.state,
        'street': address.street,
        'number': address.number,
        'quadra': address.quadra,
        'lote': address.lote,
        'reference': address.reference,
        'observation': address.observation,
      };

      final response = await _dio.post(
        '$ipHost/users/addresses/',
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
