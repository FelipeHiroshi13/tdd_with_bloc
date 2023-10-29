import '../models/user_model.dart';

abstract class IAuthenticationRemoteDataSource {
  Future<void> createUser({
    required String name,
    required String avata,
  });

  Future<List<UserModel>> getUsers();
}
