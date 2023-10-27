// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dummy_app_with_bloc/src/core/usecase/usecase.dart';
import 'package:dummy_app_with_bloc/src/core/utils/typedef.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/domain/repositories/i_authentication_repository.dart';

import '../entities/user.dart';

class GetUsers extends UsecaseWitoutParams<List<User>> {
  GetUsers({
    required this.repository,
  });

  final IAuthenticationRepository repository;

  @override
  ResultFuture<List<User>> call() async => repository.getUsers();
}
