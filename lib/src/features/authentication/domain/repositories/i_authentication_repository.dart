import '../../../../core/utils/typedef.dart';
import '../entities/user.dart';

abstract class IAuthenticationRepository {
  ResultFuture<void> createUser({required String name, required String avatar});

  ResultFuture<List<User>> getUsers();
}
