import 'package:dartz/dartz.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/domain/usecases/create_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late CreateUser usecase;
  late IAuthenticationRepository repository;

  setUpAll(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository: repository);
  });

  const params = CreateUserParams(name: 'name', avatar: 'avatar');
  test('Should call the [Repository.createUser]', () async {
    when(
      () => repository.createUser(
          name: any(named: 'name'), avatar: any(named: 'avatar')),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase(params);

    expect(result, equals(const Right(null)));

    verify(() =>
            repository.createUser(name: params.name, avatar: params.avatar))
        .called(1);
    verifyNoMoreInteractions(repository);
  });
}
