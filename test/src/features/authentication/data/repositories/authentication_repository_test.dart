import 'package:dartz/dartz.dart';
import 'package:dummy_app_with_bloc/src/core/errors/exceptions.dart';
import 'package:dummy_app_with_bloc/src/core/errors/failure.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/data/repositories/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock
    implements IAuthenticationRemoteDataSource {}

void main() {
  late IAuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepository repository;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repository = AuthenticationRepository(remoteDataSource: remoteDataSource);
  });

  const tException = APIException(
    message: 'Unknown Error Occured',
    statusCode: 500,
  );

  group('Create user', () {
    const tName = 'name';
    const tAvatar = 'avatar';
    test(
        'Should call the [RemoteDataSource.createUser] and complete successfully',
        () async {
      when(() => remoteDataSource.createUser(
          name: any(named: 'name'),
          avata: any(named: 'avata'))).thenAnswer((_) async => Future.value());

      final result = await repository.createUser(name: tName, avatar: tAvatar);
      expect(result, equals(const Right(null)));

      verify(() => remoteDataSource.createUser(name: tName, avata: tAvatar))
          .called(1);
    });

    test(
        'Should return a [ServerFailure] when the call to the remote source is unsuccessful',
        () async {
      when(() => remoteDataSource.createUser(
          name: any(named: 'name'),
          avata: any(named: 'avata'))).thenThrow(tException);

      final result = await repository.createUser(name: tName, avatar: tAvatar);

      expect(
        result,
        equals(Left(APIFailure(
            message: tException.message, statusCode: tException.statusCode))),
      );
      verify(() => remoteDataSource.createUser(name: tName, avata: tAvatar))
          .called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
