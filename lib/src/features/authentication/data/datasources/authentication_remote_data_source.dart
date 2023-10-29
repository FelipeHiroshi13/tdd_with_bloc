import 'dart:convert';

import 'package:dummy_app_with_bloc/src/core/errors/exceptions.dart';

import '../../../../core/utils/endpoints.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class IAuthenticationRemoteDataSource {
  Future<void> createUser({
    required String name,
    required String avata,
  });

  Future<List<UserModel>> getUsers();
}

class AuthenticationRemoteDataSource
    implements IAuthenticationRemoteDataSource {
  AuthenticationRemoteDataSource({required this.client});

  final http.Client client;

  @override
  Future<void> createUser({required String name, required String avata}) async {
    try {
      final response = await client.post(
          Uri.https(Endpoints.kBaseUrl, Endpoints.createUser),
          body: jsonEncode({'name': name, 'avata': avata}));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await client
          .get(Uri.https(Endpoints.kBaseUrl, Endpoints.getUsersEndpoint));

      if (response.statusCode != 200) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }

      List<dynamic> users = jsonDecode(response.body);

      return users.map((e) => UserModel.fromMap(e)).toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
