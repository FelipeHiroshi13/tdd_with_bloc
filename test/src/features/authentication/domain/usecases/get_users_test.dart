import 'package:dartz/dartz.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/domain/entities/user.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/domain/usecases/get_users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late IAuthenticationRepository repository;
  late GetUsers usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = GetUsers(repository: repository);
  });

  final tResponse = [
    User(id: '', name: 'name', createdAt: DateTime.now(), avatar: 'avatar')
  ];

  test('Should call [AuthRepo.getUsers] and return [List<User>]', () async {
    when(() => repository.getUsers()).thenAnswer((_) async => Right(tResponse));

    final result = await usecase();

    expect(result, equals(Right(tResponse)));
    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
