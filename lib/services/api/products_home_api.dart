import 'package:dio/dio.dart';
import 'package:projeto_de_sistemas/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projeto_de_sistemas/domain/models/products/product.dart';
import 'package:projeto_de_sistemas/utils/api_configs.dart';

class ProductControllerApi {
  final Dio _dio;
  final SharedPreferences _prefs;

  ProductControllerApi()
    : _dio = getIt<Dio>(),
      _prefs = getIt<SharedPreferences>();
  ProductControllerApi.testable({
    required Dio dio,
    required SharedPreferences prefs,
  }) : _dio = dio,
       _prefs = prefs;

  Future<List<Product>> fetchProducts() async {
    try {
      final token = _prefs.getString('access_token');

      if (token == null) {
        throw Exception('Token não encontrado. Usuário não autenticado.');
      }

      final response = await _dio.get(
        '$ipHost/produtos/api/produtos/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map<Product>((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao buscar produtos: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Sessão expirada. Faça login novamente.');
      }
      throw Exception('Erro ao buscar produtos: ${e.message}');
    } catch (e) {
      throw Exception('Erro ao buscar produtos: $e');
    }
  }
}
