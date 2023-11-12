import 'package:dartz/dartz.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/domain/entities/user.dart';
import 'package:dummy_app_with_bloc/src/core/utils/typedef.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/domain/repositories/i_authentication_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  AuthenticationRepository({required this.remoteDataSource});

  final IAuthenticationRemoteDataSource remoteDataSource;

  @override
  ResultFuture<void> createUser(
      {required String name, required String avatar}) async {
    try {
      await remoteDataSource.createUser(name: name, avata: avatar);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromExeption(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await remoteDataSource.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromExeption(e));
    }
  }
}
