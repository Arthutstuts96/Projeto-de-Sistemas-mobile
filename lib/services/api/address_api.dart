import 'package:dio/dio.dart';
import 'package:projeto_de_sistemas/domain/models/users/address.dart';
import 'package:projeto_de_sistemas/locator.dart';
import 'package:projeto_de_sistemas/services/session/user_session.dart';
import 'package:projeto_de_sistemas/utils/api_configs.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO: ids de usuários nos cadastros serem o ID real do usuário, e não 1
class AddressApi {
  final Dio _dio;
  final SharedPreferences _prefs;
  final UserSession _userSession;

  AddressApi()
    : _dio = getIt<Dio>(),
      _prefs = getIt<SharedPreferences>(),
      _userSession = getIt<UserSession>();
  AddressApi.testable({
    required Dio dio,
    required SharedPreferences prefs,
    required UserSession userSession,
  }) : _dio = dio,
       _prefs = prefs,
       _userSession = userSession;

  Future<List<Address>> getAllAdresses() async {
    try {
      final token = _prefs.getString('access_token');

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

  Future<List<Address>> getAllAdressesByUserEmail() async {
    try {
      final token = _prefs.getString('access_token');
      final user = await _userSession.getUserFromSession();

      if (token == null || user == null) {
        throw Exception('Token não encontrado. Usuário não autenticado.');
      }

      final response = await _dio.get(
        // '$ipHost/users/addresses/get/${user.email}',
        '$ipHost/gerenciamento/api/enderecos/',
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
      final token = _prefs.getString('access_token');

      if (token == null) {
        throw Exception('Token não encontrado. Usuário não autenticado.');
      }

      final body = {
        // "user": address.user,
        "user": 1,
        "zip_code": address.zip_code,
        "street": address.street,
        "number": address.number,
        "complement": address.complement,
        "neighborhood": address.neighborhood,
        "city": address.city,
        "state": address.state,
      };

      final response = await _dio.post(
        '$ipHost/gerenciamento/api/enderecos/',
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}
