// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:projeto_de_sistemas/domain/models/users/address.dart';
// import 'package:projeto_de_sistemas/domain/models/users/user.dart';
// import 'package:projeto_de_sistemas/services/api/address_api.dart';
// import 'package:projeto_de_sistemas/services/session/user_session.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MockDio extends Mock implements Dio {}

// class MockSharedPreferences extends Mock implements SharedPreferences {}

// class MockUserSession extends Mock implements UserSession {}

// void main() {
//   late AddressApi api;
//   late MockDio mockDio;
//   late MockSharedPreferences mockPrefs;
//   late MockUserSession mockUserSession;

//   const fakeToken = 'fake_access_token';
//   final fakeUser = User(
//     firstName: 'Test',
//     lastName: 'User',
//     completeName: 'Test User',
//     dateJoined: DateTime.now(),
//     isActive: true,
//     isStaff: false,
//     isSuperuser: false,
//     lastLogin: DateTime.now(),
//     cpf: '12345678900',
//     phone: '999999999',
//     password: 'password123',
//     email: 'test@test.com',
//   );

//   final fakeAddressJsonList = [
//     {
//       'id': 1,
//       'city': 'Palmas',
//       'state': 'TO',
//       'street': 'Av. Juscelino Kubitschek',
//       'number': '123',
//     },
//     {
//       'id': 2,
//       'city': 'Porto Nacional',
//       'state': 'TO',
//       'street': 'Av. Beira Rio',
//       'number': '456',
//     },
//   ];

//   setUp(() {
//     mockDio = MockDio();
//     mockPrefs = MockSharedPreferences();
//     mockUserSession = MockUserSession();

//     api = AddressApi.testable(
//       dio: mockDio,
//       prefs: mockPrefs,
//       userSession: mockUserSession,
//     );
//   });

//   group('getAllAdresses', () {
//     test('deve retornar uma lista de endereços em caso de sucesso', () async {
//       // 1. Simular que existe um token salvo
//       when(() => mockPrefs.getString('access_token')).thenReturn(fakeToken);
//       // 2. Simular a resposta de sucesso do Dio
//       when(() => mockDio.get(any(), options: any(named: 'options'))).thenAnswer(
//         (_) async => Response(
//           requestOptions: RequestOptions(path: ''),
//           statusCode: 200,
//           data: fakeAddressJsonList,
//         ),
//       );

//       final addresses = await api.getAllAdresses();

//       expect(addresses, isA<List<Address>>());
//       expect(addresses.length, 2);
//       expect(addresses.first.city, 'Palmas');
//     });

//     test('deve lançar uma exceção se o token não for encontrado', () async {
//       when(() => mockPrefs.getString('access_token')).thenReturn(null);

//       expect(
//         () => api.getAllAdresses(),
//         throwsA(
//           isA<Exception>().having(
//             (e) => e.toString(),
//             'message',
//             contains('Token não encontrado'),
//           ),
//         ),
//       );
//     });
//   });

//   group('getAllAdressesByUserEmail', () {
//     test(
//       'deve retornar uma lista de endereços para um usuário específico',
//       () async {
//         // ARRANGE
//         when(() => mockPrefs.getString('access_token')).thenReturn(fakeToken);
//         when(
//           () => mockUserSession.getUserFromSession(),
//         ).thenAnswer((_) async => fakeUser);
//         when(
//           () => mockDio.get(any(), options: any(named: 'options')),
//         ).thenAnswer(
//           (_) async => Response(
//             requestOptions: RequestOptions(path: ''),
//             statusCode: 200,
//             data: fakeAddressJsonList,
//           ),
//         );

//         final addresses = await api.getAllAdressesByUserEmail();

//         expect(addresses.length, 2);
//         verify(
//           () => mockDio.get(
//             contains(fakeUser.email)
//                 as String, // Verifica se o email está na URL
//             options: any(named: 'options'),
//           ),
//         ).called(1);
//       },
//     );

//     test(
//       'deve lançar uma exceção se o usuário não for encontrado na sessão',
//       () async {
//         // ARRANGE
//         when(() => mockPrefs.getString('access_token')).thenReturn(fakeToken);
//         when(
//           () => mockUserSession.getUserFromSession(),
//         ).thenAnswer((_) async => null);

//         expect(
//           () => api.getAllAdressesByUserEmail(),
//           throwsA(
//             isA<Exception>().having(
//               (e) => e.toString(),
//               'message',
//               contains('Token não encontrado'),
//             ),
//           ),
//         );
//       },
//     );
//   });

//   group('saveAddress', () {
//     final addressToSave = Address.fromMap(fakeAddressJsonList.first);

//     test('deve retornar true ao salvar com sucesso (status 201)', () async {
//       when(() => mockPrefs.getString('access_token')).thenReturn(fakeToken);
//       when(
//         () => mockDio.post(
//           any(),
//           data: any(named: 'data'),
//           options: any(named: 'options'),
//         ),
//       ).thenAnswer(
//         (_) async =>
//             Response(requestOptions: RequestOptions(path: ''), statusCode: 201),
//       );

//       final result = await api.saveAddress(address: addressToSave);

//       expect(result, isTrue);
//     });

//     test(
//       'deve retornar false se a API retornar um status code diferente de 201',
//       () async {
//         when(() => mockPrefs.getString('access_token')).thenReturn(fakeToken);
//         when(
//           () => mockDio.post(
//             any(),
//             data: any(named: 'data'),
//             options: any(named: 'options'),
//           ),
//         ).thenAnswer(
//           (_) async => Response(
//             requestOptions: RequestOptions(path: ''),
//             statusCode: 400,
//           ),
//         );

//         final result = await api.saveAddress(address: addressToSave);

//         expect(result, isFalse);
//       },
//     );

//     test('deve retornar false se o Dio lançar uma exceção', () async {
//       when(() => mockPrefs.getString('access_token')).thenReturn(fakeToken);
//       when(
//         () => mockDio.post(
//           any(),
//           data: any(named: 'data'),
//           options: any(named: 'options'),
//         ),
//       ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

//       final result = await api.saveAddress(address: addressToSave);

//       expect(result, isFalse);
//     });
//   });
// }
