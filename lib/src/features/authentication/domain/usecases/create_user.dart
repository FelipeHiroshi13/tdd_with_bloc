import 'package:equatable/equatable.dart';

import 'package:dummy_app_with_bloc/src/core/usecase/usecase.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/domain/repositories/i_authentication_repository.dart';

import '../../../../core/utils/typedef.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  CreateUser({required this.repository});

  final IAuthenticationRepository repository;

  @override
  ResultFuture<void> call(CreateUserParams params) =>
      repository.createUser(name: params.name, avatar: params.avatar);
}

class CreateUserParams extends Equatable {
  const CreateUserParams({
    required this.name,
    required this.avatar,
  });

  final String name;
  final String avatar;

  @override
  List<Object> get props => [name, avatar];
}
