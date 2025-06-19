import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:projeto_de_sistemas/services/api/register_user_api.dart';
import 'package:projeto_de_sistemas/utils/api_configs.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late RegisterUserApi api;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    api = RegisterUserApi.testable(dio: mockDio);
  });

  final user = User(
    firstName: 'Test',
    lastName: 'User',
    completeName: 'Test User',
    dateJoined: DateTime.now(),
    isActive: true,
    isStaff: false,
    isSuperuser: false,
    lastLogin: DateTime.now(),
    cpf: '12345678900',
    phone: '999999999',
    password: 'password123',
    email: 'test@test.com',
  );

  final url = '$ipHost/api/signup/';

  group('RegisterUserApi', () {
    // --- TESTE 1: CENÁRIO DE SUCESSO ---
    test(
      'deve retornar true quando o cadastro for bem-sucedido (status 201)',
      () async {
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: url),
            statusCode: 201,
          ),
        );

        final result = await api.saveUser(user: user);

        expect(result, isTrue);
      },
    );

    // --- TESTE 2: CENÁRIO DE FALHA DA API ---
    test(
      'deve retornar false quando a API retornar um status code diferente de 201',
      () async {
        // ARRANGE: Configure o mock para simular uma falha (ex: erro de validação 400)
        when(
          () => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: url),
            statusCode: 400, // Falha!
          ),
        );

        final result = await api.saveUser(user: user);

        expect(result, isFalse);
      },
    );

    // --- TESTE 3: CENÁRIO DE ERRO DE REDE ---
    test('deve retornar false quando o Dio lançar uma exceção', () async {
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: url)));

      final result = await api.saveUser(user: user);

      expect(result, isFalse);
    });
  });
}
