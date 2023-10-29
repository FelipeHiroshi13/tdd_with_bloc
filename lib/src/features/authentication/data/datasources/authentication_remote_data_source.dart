import 'dart:convert';

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
    await client.post(
        Uri.parse('${Endpoints.kBaseUrl}/${Endpoints.createUser}'),
        body: jsonEncode({'name': name, 'avata': avata}));
  }

  @override
  Future<List<UserModel>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
