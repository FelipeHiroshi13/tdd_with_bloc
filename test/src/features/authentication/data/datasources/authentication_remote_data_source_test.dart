import 'dart:convert';

import 'package:dummy_app_with_bloc/src/core/errors/exceptions.dart';
import 'package:dummy_app_with_bloc/src/core/utils/endpoints.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late IAuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthenticationRemoteDataSource(client: client);
    registerFallbackValue(Uri());
  });

  group('Create User', () {
    test('Should complete successfully when the status code is 200 or 201',
        () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('User created successfully', 201));

      final methodCall = remoteDataSource.createUser;

      expect(methodCall(name: 'name', avata: 'avata'), completes);

      verify(
        () => client.post(
          Uri.https(Endpoints.kBaseUrl, Endpoints.createUser),
          body: jsonEncode({
            'name': 'name',
            'avata': 'avata',
          }),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test('Should throw [APIException] when the status code is not 200 or 201',
        () {
      when(() => client.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('Invalid email address', 400));

      final methodCall = remoteDataSource.createUser;

      expect(
        () async => methodCall(name: 'name', avata: 'avata'),
        throwsA(const APIException(
            message: 'Invalid email address', statusCode: 400)),
      );

      verify(
        () => client.post(
          Uri.https(Endpoints.kBaseUrl, Endpoints.createUser),
          body: jsonEncode({
            'name': 'name',
            'avata': 'avata',
          }),
        ),
      ).called(1);
    });
  });

  group('getUsers', () {
    final tUsers = [UserModel.empty()];
    test('Should return [List<User>] when the status code is 200', () async {
      when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200));

      final result = await remoteDataSource.getUsers();

      expect(result, equals(tUsers));

      verify(() => client.get(
            Uri.https(Endpoints.kBaseUrl, Endpoints.getUsersEndpoint),
          )).called(1);

      verifyNoMoreInteractions(client);
    });

    test('Should throw [APIException] when the status code is not 200',
        () async {
      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response('Sercer down', 500));

      final methodCall = remoteDataSource.getUsers;

      expect(() => methodCall(),
          throwsA(const APIException(message: 'Sercer down', statusCode: 500)));

      verify(() => client.get(
            Uri.https(Endpoints.kBaseUrl, Endpoints.getUsersEndpoint),
          )).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
