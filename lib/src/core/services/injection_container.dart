import 'package:dummy_app_with_bloc/src/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/data/repositories/authentication_repository.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/domain/usecases/create_user.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/domain/usecases/get_users.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../features/authentication/domain/repositories/i_authentication_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // App logic
    ..registerFactory(() =>
        AuthenticationCubit(createUserUseCase: sl(), getUsersUseCase: sl()))

    // Use cases
    ..registerLazySingleton(() => CreateUser(repository: sl()))
    ..registerLazySingleton(() => GetUsers(repository: sl()))

    // Repositories
    ..registerLazySingleton<IAuthenticationRepository>(
        () => AuthenticationRepository(remoteDataSource: sl()))

    // Data Sources
    ..registerLazySingleton<IAuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSource(client: sl()))
    ..registerLazySingleton(() => http.Client());
}


// Future<void> init() async {
//   sl
//     // App Logic
//     ..registerFactory(() => AuthenticationCubit(
//           createUser: sl(),
//           getUsers: sl(),
//         ))

//     // Use cases
//     ..registerLazySingleton(() => CreateUser(sl()))
//     ..registerLazySingleton(() => GetUsers(sl()))

//     // Repositories
//     ..registerLazySingleton<AuthenticationRepository>(
//         () => AuthenticationRepositoryImplementation(sl()))

//     // Data Sources
//     ..registerLazySingleton<AuthenticationRemoteDataSource>(
//         () => AuthRemoteDataSrcImpl(sl()))

//     // External Dependencies
//     ..registerLazySingleton(http.Client.new);
// }
